class_name TacticalFpsPlayerController
extends BasePlayerController


func set_target(target: Vector2) -> void:
	if not is_dead():
		_player.move_to(target)
