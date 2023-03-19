class_name TacticalFpsMatch
extends BaseMatch


enum State {
	ROUND_STARTING,
	ROUND_IN_PROGRESS,
	ROUND_ENDED
}


@export_node_path("Timer") var _round_timer_path: NodePath
@export_node_path("Timer") var _bomb_timer_path: NodePath
@export_node_path("Timer") var _start_round_timer_path: NodePath
@export_node_path("Timer") var _end_round_timer_path: NodePath

@export var _win_condition_rounds_count: int = 16

@export var _round_ends_winning_team: TacticalFpsTeam.Side = TacticalFpsTeam.Side.BLUE
@export var _round_bomb_explodes_winning_team: TacticalFpsTeam.Side = TacticalFpsTeam.Side.RED

@export var _round_duration: float = 30.0
@export var _bomb_duration: float = 30.0
@export var _start_round_delay: float = 2.0
@export var _end_round_delay: float = 3.0

@onready var _round_timer: Timer = get_node(_round_timer_path)
@onready var _bomb_timer: Timer = get_node(_bomb_timer_path)
@onready var _start_round_timer: Timer = get_node(_start_round_timer_path)
@onready var _end_round_timer: Timer = get_node(_end_round_timer_path)

var _score: Dictionary = {} 
var _state: int = State.ROUND_STARTING


func _ready() -> void:
	_round_timer.one_shot = true
	_round_timer.wait_time = _round_duration
	assert(_round_timer.timeout.connect(_on_round_timer_timeout) == OK)
	
	_bomb_timer.one_shot = true
	_bomb_timer.wait_time = _bomb_duration
	assert(_bomb_timer.timeout.connect(_on_bomb_timer_timeout) == OK)
	
	_start_round_timer.one_shot = true
	_start_round_timer.wait_time = _start_round_delay
	assert(_start_round_timer.timeout.connect(_on_start_round_timer_timeout) == OK)
	
	_end_round_timer.one_shot = true
	_end_round_timer.wait_time = _end_round_delay
	assert(_end_round_timer.timeout.connect(_on_end_round_timer_timeout) == OK)
	
	init(TacticalFpsTeam.all_sides(), 2)
	start()


func init(teams: Array[TacticalFpsTeam.Side], team_players_count: int) -> void:
	super(teams, team_players_count)
	for team in teams:
		_score[team] = 0
		assert(_team_controllers[team].team_dead.connect(_on_team_dead) == OK)


func start() -> void:
	_state = State.ROUND_STARTING
	_start_round_timer.start()


func start_round() -> void:
	for team in _teams:
		for player in _team_players[team]:
			player.spawn()
	for controller in _team_controllers.values():
		controller.start_round()
	_round_timer.start()
	_state = State.ROUND_IN_PROGRESS


func end_round(winner: TacticalFpsTeam.Side) -> void:
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
	for team in _teams:
		for player in _team_players[team]:
			player.despawn()
	_state = State.ROUND_STARTING
	_start_round_timer.start()


func _on_team_dead(team: TacticalFpsTeam.Side) -> void:
	end_round(1 - team)


func _on_round_timer_timeout() -> void:
	end_round(_round_ends_winning_team)


func _on_bomb_timer_timeout() -> void:
	end_round(_round_bomb_explodes_winning_team)
