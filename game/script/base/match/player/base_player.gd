class_name BasePlayer
extends CharacterBody2D


signal navigation_finished
signal saw(body)
signal stopped_seeing(body)
signal heard(position)
signal hitted(hitter)
signal dead(killer)


@export_node_path("NavigationAgent2D") var _navigation_agent_path: NodePath
@export_node_path("Vision") var _vision_path: NodePath
@export_node_path("Hearing") var _hearing_path: NodePath
@export_node_path("HealthBar") var _health_bar_path: NodePath

@export var _max_health: float = 100.0
@export var _max_speed: float = 100.0
@export var _max_rotation_speed: float = PI

@onready var _navigation_agent: NavigationAgent2D = get_node(_navigation_agent_path)
@onready var _vision: Vision = get_node(_vision_path)
@onready var _hearing: Hearing = get_node(_hearing_path)
@onready var _health_bar: HealthBar = get_node(_health_bar_path)

var team: int = -1
var index: int = -1
var health: float = 0.0


func _ready() -> void:
	assert(_vision.detected.connect(_on_vision_detected) == OK)
	assert(_vision.lost.connect(_on_vision_lost) == OK)
	assert(_hearing.detected.connect(_on_hearing_detected) == OK)
	assert(_navigation_agent.navigation_finished.connect(_on_navigation_finished) == OK)
	_health_bar.init(_max_health)
	health = _max_health


func _physics_process(_delta: float) -> void:
	if _navigation_agent.is_navigation_finished():
		return
	
	var direction: Vector2 = global_position.direction_to(_navigation_agent.get_next_path_position())
	var _velocity = _max_speed * direction
	_navigation_agent.set_velocity(_velocity)
	set_velocity(_velocity)
	move_and_slide()
	_velocity = velocity
	rotation = _velocity.angle()


func init(_team: int, _index: int) -> void:
	self.team = _team
	self.index = _index
	self.health = _max_health


func can_see(body: CharacterBody2D) -> bool:
	return _vision.can_see(body)


func move_to(target: Vector2) -> void:
	_navigation_agent.target_position = target


func rotate_to(delta: float, target: Vector2) -> void:
	var angle_delta: float = delta * _max_rotation_speed
	var angle: float = (target - position).angle()
	rotation = clamp(lerp_angle(rotation, angle, 1), rotation - angle_delta, rotation + angle_delta)


func is_rotated_to(target: Vector2) -> bool:
	var angle: float = (target - position).angle()
	return rotation == angle


func stop() -> void:
	_navigation_agent.target_position = global_position


func hit(power: float, hitter: BasePlayer) -> void:
	health -= power
	print('Hitted wiht power:', power, '. Health left:', health)
	
	if health <= 0:
		health = 0
		emit_signal("dead", hitter)
	else:
		emit_signal("hitted", hitter)
	
	_health_bar.value = health


func _on_vision_detected(body: Object) -> void:
	if body is CharacterBody2D:
		emit_signal("saw", body)


func _on_vision_lost(body: Object) -> void:
	if body is CharacterBody2D:
		emit_signal("stopped_seeing", body)


# TODO add type
func _on_hearing_detected(detected_position: Vector2) -> void:
	emit_signal("heard", detected_position)


func _on_navigation_finished() -> void:
	emit_signal("navigation_finished")
