class_name BaseMap
extends Node


@export_node_path("Node2D") var _naviagtion_path: NodePath

@onready var _navigation: Node2D = get_node(_naviagtion_path)

# TODO [TEST] Remove later
var _test_player: BasePlayer = null


func spawn_player(_player: BasePlayer) -> void:
	# TODO [TEST] Remove later
	_test_player = _player
	
	var player_position: Vector2 = get_starting_position(_player)
	_player.position = player_position
	_navigation.add_child(_player)


func get_starting_position(_player: BasePlayer) -> Vector2:
	return Vector2.ZERO
