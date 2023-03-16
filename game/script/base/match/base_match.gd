class_name BaseMatch
extends Node


signal end_match(winner)


@export_node_path("BaseMap") var map_path: NodePath

@export var _team_controller_scene: PackedScene = null
@export var _player_controller_scene: PackedScene = null

@onready var map: BaseMap = get_node(map_path)

var _team_players_count: int = -1
var _team_controllers: Dictionary = {}
var _team_players: Dictionary = {}
var _teams: Array = []


func _process(_delta: float) -> void:
	for controller in _team_controllers.values():
		controller.process()


func init(teams: Array, team_players_count: int) -> void:
	_teams = teams
	_team_players_count = team_players_count
	for team in teams:
		var controller: BaseTeamController = _team_controller_scene.instantiate()
		add_child(controller)
		_team_controllers[team] = controller
		
		var players: Array[BasePlayerController] = []
		for i in range(_team_players_count):
			var player: BasePlayerController = _player_controller_scene.instantiate()
			player.init(team, i, self)
			players.append(player)
			controller.add_child(player)
		_team_players[team] = players
		
		controller.init(team, players, self)


func start() -> void:
	pass
