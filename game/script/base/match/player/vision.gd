class_name Vision
extends RayCast2D


signal detected(body)
signal lost(body)


@export var _cone_of_vision_degrees: float = 100.0
@export var _rays_count: int = 50

var _direction: Vector2 = target_position
var _last_detected_bodies = []


func _physics_process(_delta: float) -> void:
	var cone_of_vision_step: float = _cone_of_vision_degrees / (_rays_count - 1.0)
	var align_index: float = (_rays_count - 1.0) / 2.0
	
	var detected_bodies: Array[Object] = []
	for i in range(_rays_count):
		var current_cone_of_vision_angle: float = deg_to_rad((i - align_index) * cone_of_vision_step)
		var current_cast_to_vector: Vector2 = _direction.rotated(current_cone_of_vision_angle)
		target_position = current_cast_to_vector
		force_raycast_update()
		
		if is_colliding() and not detected_bodies.has(get_collider()):
			detected_bodies.append(get_collider())
	
	for detected_body in detected_bodies:
		if not _last_detected_bodies.has(detected_body):
			emit_signal("detected", detected_body)
	
	for last_detected_body in _last_detected_bodies:
		if not detected_bodies.has(last_detected_body):
			emit_signal("lost", last_detected_body)
	
	_last_detected_bodies = detected_bodies
	target_position = _direction


func can_see(body: CharacterBody2D) -> bool:
	return _last_detected_bodies.has(body)
