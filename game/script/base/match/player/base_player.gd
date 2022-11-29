class_name BasePlayer
extends KinematicBody2D


export (NodePath) onready var navigation_agent = get_node(navigation_agent) as NavigationAgent2D
export (NodePath) onready var vision = get_node(vision) as RayCast2D

export (float) var max_health: float = 100.0
export (float) var max_speed: float = 100.0
export (float) var max_rotation_speed: float = PI

var team: int = -1
var player_number: int = -1
var health: float = 0.0


func init(_team: int, _player_number: int) -> void:
	self.team = _team
	self.player_number = _player_number
	self.health = max_health


func _ready() -> void:
	vision.connect("player_detected", self, "_on_player_detected")
	health = max_health


func _physics_process(_delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		return
	
	var direction: Vector2 = global_position.direction_to(navigation_agent.get_next_location())
	var _velocity = max_speed * direction
	navigation_agent.set_velocity(_velocity)
	_velocity = move_and_slide(_velocity)
	rotation = _velocity.angle()


func move_to(target: Vector2) -> void:
	navigation_agent.set_target_location(target)


func rotate_to(delta: float, target: Vector2) -> void:
	var angle_delta: float = delta * max_rotation_speed
	var angle: float = (target - position).angle()
	rotation = clamp(lerp_angle(rotation, angle, 1), rotation - angle_delta, rotation + angle_delta)


func stop() -> void:
	navigation_agent.set_target_location(global_position)


func hit(power: float) -> void:
	health -= power
	print('Hitted wiht power:', power, '. Health left:', health)


# Can't use BasePlayer type because of circylar dependency
func _on_player_detected(player: KinematicBody2D) -> void:
	if player.team != team:
		_on_enemy_detected(player)


# Can't use BasePlayer type because of circylar dependency
func _on_enemy_detected(_enemy: KinematicBody2D) -> void:
	pass
