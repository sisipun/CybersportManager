class_name BaseMatch
extends Node

export (NodePath) onready var map = get_node(map) as BaseMap
export (PackedScene) var player_controller_scene: PackedScene = null
export (PackedScene) var player_scene: PackedScene = null

var team_players_count: int = -1
var team_controllers: Dictionary = {}


func init(teams: Array, _team_players_count: int) -> void:
	team_players_count = _team_players_count
	for team in teams:
		var controller: BasePlayerController = player_controller_scene.instance()
		controller.init(team)
		add_child(controller)
		team_controllers[team] = controller
		
		for _i in range(team_players_count):
			var player: BasePlayer = player_scene.instance()
			player.init(team, _i)
			map.add_player(player)
	
	for controller in team_controllers.values():
		controller.before_start(map)


func _process(_delta: float) -> void:
	for controller in team_controllers.values():
		controller.process(map)
