class_name BaseMap
extends Node


# TODO [TEST] Remove later
var _test_player: BasePlayer = null


func spawn_player(_player: BasePlayer) -> void:
	# TODO [TEST] Remove later
	_test_player = _player
	
	var player_position: Vector2 = get_starting_position(_player)
	_player.position = player_position
	add_child(_player)


func get_starting_position(_player: BasePlayer) -> Vector2:
	return Vector2.ZERO
