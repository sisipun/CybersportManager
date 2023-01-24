class_name BasePlayerVision
extends RayCast2D


signal detected(bodies)


export (float) var _cone_of_vision_degrees: float = 100.0
export (int) var _rays_count: int = 50

var _direction: Vector2 = cast_to
var _last_detected_bodies = []


func _physics_process(_delta: float) -> void:
	var cone_of_vision_step: float = _cone_of_vision_degrees / (_rays_count - 1.0)
	var align_index: float = (_rays_count - 1.0) / 2.0
	
	var bodies: Array = []
	for i in range(_rays_count):
		var current_cone_of_vision_angle: float = deg2rad((i - align_index) * cone_of_vision_step)
		var current_cast_to_vector: Vector2 = _direction.rotated(current_cone_of_vision_angle)
		cast_to = current_cast_to_vector
		force_raycast_update()
		
		if is_colliding() and not bodies.has(get_collider()):
			# TODO maybe remove later
			if get_collider() is BasePlayer:
				bodies.append(get_collider())
	
	if not is_equals_ignore_order(_last_detected_bodies, bodies):
		_last_detected_bodies = bodies
		emit_signal("detected", bodies)
	
	cast_to = _direction


func can_see(body: KinematicBody2D) -> bool:
	return _last_detected_bodies.has(body)


func is_equals_ignore_order(first: Array, second: Array) -> bool:
	if first.size() != second.size():
		return false
	
	for element in first:
		if not second.has(element):
			return false
	
	return true
