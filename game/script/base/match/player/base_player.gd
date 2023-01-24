class_name BasePlayer
extends KinematicBody2D


signal navigation_finished
signal detected(bodies)
signal hitted(hitter)
signal dead(killer)


export (NodePath) onready var _navigation_agent = get_node(_navigation_agent) as NavigationAgent2D
# [CD] BasePlayerVision
export (NodePath) onready var _vision = get_node(_vision) as RayCast2D
export (NodePath) onready var _health_bar = get_node(_health_bar) as HealthBar

export (float) var _max_health: float = 100.0
export (float) var _max_speed: float = 100.0
export (float) var _max_rotation_speed: float = PI

var team: int = -1
var index: int = -1
var health: float = 0.0


func _ready() -> void:
	assert(_vision.connect("detected", self, "_on_detected") == OK)
	assert(_navigation_agent.connect("navigation_finished", self, "_on_navigation_finished") == OK)
	_health_bar.init(_max_health)
	health = _max_health


func _physics_process(_delta: float) -> void:
	if _navigation_agent.is_navigation_finished():
		return
	
	var direction: Vector2 = global_position.direction_to(_navigation_agent.get_next_location())
	var _velocity = _max_speed * direction
	_navigation_agent.set_velocity(_velocity)
	_velocity = move_and_slide(_velocity)
	rotation = _velocity.angle()


func init(_team: int, _index: int) -> void:
	self.team = _team
	self.index = _index
	self.health = _max_health


func can_see(body: KinematicBody2D) -> bool:
	return _vision.can_see(body)


func move_to(target: Vector2) -> void:
	_navigation_agent.set_target_location(target)


func rotate_to(delta: float, target: Vector2) -> void:
	var angle_delta: float = delta * _max_rotation_speed
	var angle: float = (target - position).angle()
	print(angle)
	rotation = clamp(lerp_angle(rotation, angle, 1), rotation - angle_delta, rotation + angle_delta)


func stop() -> void:
	_navigation_agent.set_target_location(global_position)


# [CD] BasePlayer
func hit(power: float, hitter: KinematicBody2D) -> void:
	health -= power
	print('Hitted wiht power:', power, '. Health left:', health)
	
	if health <= 0:
		health = 0
		emit_signal("dead", hitter)
	else:
		emit_signal("hitted", hitter)
	
	_health_bar.value = health


func _on_detected(bodies: Array) -> void:
	emit_signal("detected", bodies)


func _on_navigation_finished() -> void:
	emit_signal("navigation_finished")
