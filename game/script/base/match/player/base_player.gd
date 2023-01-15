class_name BasePlayer
extends KinematicBody2D


signal dead


export (NodePath) onready var _navigation_agent = get_node(_navigation_agent) as NavigationAgent2D
export (NodePath) onready var _vision = get_node(_vision) as RayCast2D
export (NodePath) onready var _health_bar = get_node(_health_bar) as HealthBar

export (float) var _max_health: float = 100.0
export (float) var _max_speed: float = 100.0
export (float) var _max_rotation_speed: float = PI

var team: int = -1
var index: int = -1
var health: float = 0.0


func _ready() -> void:
	assert(_vision.connect("player_detected", self, "_on_player_detected") == OK)
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


func to_map_coordinates(global_position: Vector2) -> Vector2:
	return get_parent().to_local(global_position)


func move_to(target: Vector2) -> void:
	_navigation_agent.set_target_location(target)


func rotate_to(delta: float, target: Vector2) -> void:
	var angle_delta: float = delta * _max_rotation_speed
	var angle: float = (target - position).angle()
	rotation = clamp(lerp_angle(rotation, angle, 1), rotation - angle_delta, rotation + angle_delta)


func stop() -> void:
	_navigation_agent.set_target_location(global_position)


func hit(power: float) -> void:
	health -= power
	print('Hitted wiht power:', power, '. Health left:', health)
	
	if health <= 0:
		health = 0
		emit_signal("dead")
	
	_health_bar.value = health


# TODO [CD] BasePlayer
func _on_player_detected(player: KinematicBody2D) -> void:
	if player.team != team:
		_on_enemy_detected(player)


# TODO [CD] BasePlayer
func _on_enemy_detected(_enemy: KinematicBody2D) -> void:
	pass
