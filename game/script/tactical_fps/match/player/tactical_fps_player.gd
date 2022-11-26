class_name TacticalFpsPlayer
extends BasePlayer


export (float) var speed: float = 150.0


func _physics_process(_delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		return
	
	var direction: Vector2 = global_position.direction_to(navigation_agent.get_next_location())
	var _velocity = speed * direction
	navigation_agent.set_velocity(_velocity)
	_velocity = move_and_slide(_velocity)


func move_to(position: Vector2) -> void:
	navigation_agent.set_target_location(position)
