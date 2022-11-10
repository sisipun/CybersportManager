class_name TacticalFpsMap
extends Area2D


export (PackedScene) var player_scene = null

var _current_player: TacticalFpsPlayer = null


func _ready() -> void:
	_current_player = player_scene.instance()
	_current_player.position = Vector2(0, 0)
	add_child(_current_player)


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and _current_player:
		_current_player.move_to(to_local((event as InputEventMouseButton).position))
