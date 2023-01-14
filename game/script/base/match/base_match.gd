class_name BaseMatch
extends Node


# warning-ignore:unused_signal
signal end_match(winner)


export (NodePath) onready var map = get_node(map) as BaseMap
export (PackedScene) var _team_controller_scene: PackedScene = null
export (PackedScene) var _player_scene: PackedScene = null

var _team_players_count: int = -1
var _team_controllers: Dictionary = {}
var _teams: Array = []


func init(teams: Array, team_players_count: int) -> void:
	_teams = teams
	_team_players_count = team_players_count
	for team in teams:
		# Can use BaseTeamController because of circylar dependency
		var controller: Node = _team_controller_scene.instance()
		controller.init(team, self)
		add_child(controller)
		_team_controllers[team] = controller


func start() -> void:
	pass


func _process(_delta: float) -> void:
	for controller in _team_controllers.values():
		controller.process()
