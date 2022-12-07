class_name TacticalFpsMatch
extends BaseMatch


export (NodePath) onready var _next_round_timer = get_node(_next_round_timer) as Timer
export (float) var _next_round_delay: float = 3.0

var _score: Dictionary = {} 


func init(teams: Array, team_players_count: int) -> void:
	.init(teams, team_players_count)
	for team in teams:
		_score[team] = 0
	_map.connect("team_dead", self, "_on_team_dead")


func _ready() -> void:
	init(TacticalFpsTeam.Side.values(), 1)
	_next_round_timer.one_shot = true
	_next_round_timer.wait_time = _next_round_delay
	_next_round_timer.connect("timeout", self, "_on_next_round_timer_timeout")


func start_round() -> void:
	.start_round()
	for controller in _team_controllers.values():
		controller.start_round()


func end_round() -> void:
	.end_round()
	for controller in _team_controllers.values():
		controller.end_round()


func _on_team_dead(team: int) -> void:
	_next_round_timer.start()
	_score[1 - team] += 1
	print(_score)


func _on_next_round_timer_timeout() -> void:
	end_round()
	start_round()
