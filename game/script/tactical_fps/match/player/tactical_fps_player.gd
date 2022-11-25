class_name TacticalFpsPlayer
extends BasePlayer


const TARGET_EPSILON: int = 5

export (float) var speed: float = 150.0

var player_number: int = -1


func init(_team: int, _player_number: int) -> void:
	team = _team
	player_number = _player_number


func _physics_process(_delta: float) -> void:
	if ray.is_colliding() and ray.get_collider() is BasePlayer:
		var collider: TacticalFpsPlayer = ray.get_collider()
		if collider.team != team:
			print('Enemy detected')
	if navigation_agent.is_navigation_finished():
		return
	
	var direction: Vector2 = global_position.direction_to(navigation_agent.get_next_location())
	var _velocity = speed * direction
	navigation_agent.set_velocity(_velocity)
	rotation = _velocity.angle()
	_velocity = move_and_slide(_velocity)


func move_to(position: Vector2) -> void:
	navigation_agent.set_target_location(position)
