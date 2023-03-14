class_name TacticalFpsWeapon
extends Sprite2D


@export_node_path("RayCast2D") var _bullet_ray_path: NodePath
@export_node_path("Node2D") var _player_attach_point_path: NodePath
@export_node_path("Timer") var _bullet_spawn_timer_path: NodePath

@export var _bullet_power: float = 10.0
@export var _rate_of_fire: float = 300.0

@onready var _bullet_ray: RayCast2D = get_node(_bullet_ray_path)
@onready var _player_attach_point: Node2D = get_node(_player_attach_point_path)
@onready var _bullet_spawn_timer: Timer = get_node(_bullet_spawn_timer_path)

var player: BasePlayer = null
var _can_shoot: bool = true


func _ready() -> void:
	_bullet_spawn_timer.wait_time = 60.0 / _rate_of_fire
	_bullet_spawn_timer.one_shot = true
	assert(_bullet_spawn_timer.connect("timeout",Callable(self,"_on_bullet_spawn_timer_timeout")) == OK)


func init(_player: BasePlayer) -> void:
	self.player = _player
	self.position = -player.to_local(_player_attach_point.global_position)


func shoot() -> void:
	if not _can_shoot:
		return
	
	_bullet_ray.force_raycast_update()
	if _bullet_ray.is_colliding():
		var collider = _bullet_ray.get_collider()
		if collider == player:
			return
		if collider is BasePlayer:
			collider.hit(_bullet_power, player)
	
	_can_shoot = false
	_bullet_spawn_timer.start()


func forward() -> Vector2:
	return player.transform.x


func _on_bullet_spawn_timer_timeout() -> void:
	_can_shoot = true
