class_name BasePlayer
extends KinematicBody2D


export (NodePath) onready var navigation_agent = get_node(navigation_agent) as NavigationAgent2D
export (NodePath) onready var vision = get_node(vision) as RayCast2D

var team: int = -1
var player_number: int = -1


func init(_team: int, _player_number: int) -> void:
	self.team = _team
	self.player_number = _player_number


func _ready() -> void:
	vision.connect("player_detected", self, "_on_player_detected")


func _physics_process(_delta: float) -> void:
	if (team == 0):
		navigation_agent.set_target_location(get_global_mouse_position())
	if navigation_agent.is_navigation_finished():
		return
	
	var direction: Vector2 = global_position.direction_to(navigation_agent.get_next_location())
	var _velocity = navigation_agent.max_speed * direction
	navigation_agent.set_velocity(_velocity)
	_velocity = move_and_slide(_velocity)
	rotation = _velocity.angle()


func move_to(position: Vector2) -> void:
	navigation_agent.set_target_location(position)


# Can't use BasePlayer type because of circylar dependency
func _on_player_detected(player: KinematicBody2D) -> void:
	if player.team != team:
		_on_enemy_detected(player)


# Can't use BasePlayer type because of circylar dependency
func _on_enemy_detected(_enemy: KinematicBody2D) -> void:
	pass
