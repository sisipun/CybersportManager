class_name TacticalFpsMap
extends Area2D


export (PackedScene) var player_scene = null

var _current_player: TacticalFpsPlayer = null


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if _current_player:
			_current_player.queue_free()
			_current_player = null
		
		_current_player = player_scene.instance()
		print((event as InputEventMouseButton).position)
		_current_player.position = to_local((event as InputEventMouseButton).position)
		add_child(_current_player)
		print('hello')
