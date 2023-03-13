class_name BaseMatch
extends Node


# warning-ignore:unused_signal
signal end_match(winner)


@export (NodePath) onready var map = get_node(map) as BaseMap
@export (PackedScene) var _team_controller_scene: PackedScene = null
@export (PackedScene) var _player_controller_scene: PackedScene = null

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
		# TODO [CD] BaseTeamController
		var controller: Node = _team_controller_scene.instantiate()
		add_child(controller)
		_team_controllers[team] = controller
		
		var players: Array = []
		for i in range(_team_players_count):
			# TODO [CD] BasePlayerController
			var player: Node = _player_controller_scene.instantiate()
			player.init(team, i, self)
			players.append(player)
			controller.add_child(player)
		_team_players[team] = players
		
		controller.init(team, players, self)


func start() -> void:
	pass
