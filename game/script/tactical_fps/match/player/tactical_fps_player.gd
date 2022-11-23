class_name TacticalFpsPlayer
extends BasePlayer


const TARGET_EPSILON: int = 5

export (float) var speed: float = 150.0

var target: TacticalFpsPlantZone = null
var player_number: int = -1


func init(_team: int, _player_number: int) -> void:
	team = _team
	player_number = _player_number


func _physics_process(_delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		return
	
	navigation_agent.set_target_location(target.global_position)
	var direction: Vector2 = global_position.direction_to(navigation_agent.get_next_location())
	var _velocity = speed * direction
	navigation_agent.set_velocity(_velocity)
	_velocity = move_and_slide(_velocity)


func move_to(_target: TacticalFpsPlantZone) -> void:
	target = _target