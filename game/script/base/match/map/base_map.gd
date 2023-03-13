class_name BaseMap
extends Node


@export (NodePath) onready var _navigation = get_node(_navigation) as Navigation2D

# TODO [TEST] Remove later
var _player: BasePlayer = null


func spawn_player(player: BasePlayer) -> void:
	# TODO [TEST] Remove later
	_player = player
	
	var player_position: Vector2 = get_starting_position(player)
	player.position = player_position
	_navigation.add_child(player)


func get_starting_position(__player: BasePlayer) -> Vector2:
	return Vector2.ZERO
