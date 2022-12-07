class_name BasePlayerVision
extends RayCast2D


signal player_detected(player)


export (float) var _cone_of_vision_degrees: float = 100.0
export (int) var _rays_count: int = 10


var _direction: Vector2 = cast_to


func _physics_process(_delta: float) -> void:
	var cone_of_vision_step: float = _cone_of_vision_degrees / (_rays_count - 1.0)
	var align_index: float = (_rays_count - 1.0) / 2.0

	for i in range(_rays_count):
		var current_cone_of_vision_angle: float = deg2rad((i - align_index) * cone_of_vision_step)
		var current_cast_to_vector: Vector2 = _direction.rotated(current_cone_of_vision_angle)
		cast_to = current_cast_to_vector
		force_raycast_update()
		
		if is_colliding() and get_collider() is BasePlayer:
			emit_signal("player_detected", get_collider())
			break
	
	cast_to = _direction
