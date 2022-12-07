class_name BaseMatch
extends Node


export (NodePath) onready var _map = get_node(_map) as BaseMap
export (PackedScene) var _player_controller_scene: PackedScene = null
export (PackedScene) var _player_scene: PackedScene = null

var _team_players_count: int = -1
var _team_controllers: Dictionary = {}
var _teams: Array = []


func init(teams: Array, team_players_count: int) -> void:
	_teams = teams
	_team_players_count = team_players_count
	for team in teams:
		var controller: BasePlayerController = _player_controller_scene.instance()
		controller.init(team)
		add_child(controller)
		_team_controllers[team] = controller
	
	start_round()


func start_round() -> void:
	for team in _teams:
		for i in range(_team_players_count):
			var player: BasePlayer = _player_scene.instance()
			player.init(team, i)
			_map.add_player(player)


func end_round() -> void:
	_map.clear()


func _process(_delta: float) -> void:
	for controller in _team_controllers.values():
		controller.process(_map)
