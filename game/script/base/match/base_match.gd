class_name BaseMatch
extends Node

export (NodePath) onready var map = get_node(map) as BaseMap
export (PackedScene) var player_controller_scene: PackedScene = null
export (PackedScene) var player_scene: PackedScene = null

var team_controllers: Dictionary = {}


func init(teams: Array, team_players_count: int) -> void:
	for team in teams:
		var controller: BasePlayerController = player_controller_scene.instance()
		controller.init(team)
		add_child(controller)
		team_controllers[team] = controller
		
		for _i in range(team_players_count):
			var player: BasePlayer = player_scene.instance()
			player.init(team)
			map.add_player(player)


func _process(_delta: float) -> void:
	for controller in team_controllers.values():
		controller.process(map)
