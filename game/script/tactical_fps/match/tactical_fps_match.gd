class_name TacticalFpsMatch
extends BaseMatch


enum State {
	ROUND_STARTING,
	ROUND_IN_PROGRESS,
	ROUND_ENDED
}


export (NodePath) onready var _round_timer = get_node(_round_timer) as Timer
export (NodePath) onready var _bomb_timer = get_node(_bomb_timer) as Timer
export (NodePath) onready var _start_round_timer = get_node(_start_round_timer) as Timer
export (NodePath) onready var _end_round_timer = get_node(_end_round_timer) as Timer

export (int) var _win_condition_rounds_count: int = 16

export (TacticalFpsTeam.Side) var _round_ends_winning_team: int = TacticalFpsTeam.Side.BLUE
export (TacticalFpsTeam.Side) var _round_bomb_explodes_winning_team: int = TacticalFpsTeam.Side.RED

export (float) var _round_duration: float = 10.0
export (float) var _bomb_duration: float = 30.0
export (float) var _start_round_delay: float = 2.0
export (float) var _end_round_delay: float = 3.0

var _score: Dictionary = {} 
var _state: int = State.ROUND_STARTING


func _ready() -> void:
	_round_timer.one_shot = true
	_round_timer.wait_time = _round_duration
	_round_timer.connect("timeout", self, "_on_round_timer_timeout")
	
	_bomb_timer.one_shot = true
	_bomb_timer.wait_time = _bomb_duration
	_bomb_timer.connect("timeout", self, "_on_bomb_timer_timeout")
	
	_start_round_timer.one_shot = true
	_start_round_timer.wait_time = _start_round_delay
	_start_round_timer.connect("timeout", self, "_on_start_round_timer_timeout")
	
	_end_round_timer.one_shot = true
	_end_round_timer.wait_time = _end_round_delay
	_end_round_timer.connect("timeout", self, "_on_end_round_timer_timeout")
	
	init(TacticalFpsTeam.Side.values(), 2)


func init(teams: Array, team_players_count: int) -> void:
	.init(teams, team_players_count)
	for team in teams:
		_score[team] = 0
	_map.connect("team_dead", self, "_on_team_dead")


func start() -> void:
	_state = State.ROUND_STARTING
	_start_round_timer.start()


func start_round() -> void:
	for team in _teams:
		for i in range(_team_players_count):
			var player: BasePlayer = _player_scene.instance()
			player.init(team, i)
			_map.add_player(player)
	for controller in _team_controllers.values():
		controller.start_round(_map)
	_round_timer.start()
	_state = State.ROUND_IN_PROGRESS


func end_round(winner: int) -> void:
	if _state != State.ROUND_IN_PROGRESS:
		return
	
	_state = State.ROUND_ENDED
	_round_timer.stop()
	_bomb_timer.stop()
	
	for controller in _team_controllers.values():
		controller.end_round()
	
	_score[winner] += 1
	print(_score)
	if _score[winner] >= _win_condition_rounds_count:
		emit_signal("end_match", winner)
		print('End match. Winner: ', winner)
	else:
		_end_round_timer.start()


func _on_start_round_timer_timeout() -> void:
	start_round()


func _on_end_round_timer_timeout() -> void:
	_map.clear()
	_state = State.ROUND_STARTING
	_start_round_timer.start()


func _on_team_dead(team: int) -> void:
	end_round(1 - team)


func _on_round_timer_timeout() -> void:
	end_round(_round_ends_winning_team)


func _on_bomb_timer_timeout() -> void:
	end_round(_round_bomb_explodes_winning_team)
