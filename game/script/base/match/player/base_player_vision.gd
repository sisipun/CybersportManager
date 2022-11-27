class_name BasePlayerVision
extends RayCast2D


signal player_detected(player)


export (float) var cone_of_vision: float = 100.0
export (int) var rays_count: int = 10


func _physics_process(_delta: float) -> void:
	var cast_to_vector: Vector2 = Vector2(cast_to.x, cast_to.y)
	var cone_of_vision_step: float = cone_of_vision / (rays_count - 1.0)
	var align_index: float = (rays_count - 1.0) / 2.0

	for i in range(rays_count):
		var current_cone_of_vision_angle: float = deg2rad((i - align_index) * cone_of_vision_step)
		var current_cast_to_vector: Vector2 = cast_to_vector.rotated(current_cone_of_vision_angle)
		cast_to = current_cast_to_vector
		force_raycast_update()
		
		if is_colliding() and get_collider() is BasePlayer:
			emit_signal("player_detected", get_collider())
			break
	
	cast_to = cast_to_vector