class_name BaseMap
extends Node


export (NodePath) onready var navigation = get_node(navigation) as Navigation2D

var players: Dictionary = {}


func add_player(player: BasePlayer) -> void:
	if not (players.has(player.team)):
		players[player.team] = []
	
	assert(player.connect("dead", self, "_on_player_dead", [player]) == OK)
	
	var team_players: Array = players[player.team]
	var player_position: Vector2 = get_starting_position(player)
	player.position = player_position
	navigation.add_child(player)
	team_players.append(player)


func get_starting_position(_player: BasePlayer) -> Vector2:
	return Vector2.ZERO


func _on_player_dead(player: BasePlayer) -> void:
	players[player.team].erase(player)
