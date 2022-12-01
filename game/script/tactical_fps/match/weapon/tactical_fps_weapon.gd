class_name TacticalFpsWeapon
extends Sprite


export (NodePath) onready var _bullet_spawn_point = get_node(_bullet_spawn_point) as Node2D
export (NodePath) onready var _player_attach_point = get_node(_player_attach_point) as Node2D
export (NodePath) onready var _bullet_spawn_timer = get_node(_bullet_spawn_timer) as Timer

export (PackedScene) var _bullet_scene: PackedScene = null

export (float) var _bullet_power: float = 30.0
export (float) var _bullet_speed: float = 30.0
export (float) var _rate_of_fire: float = 60.0

var player: BasePlayer = null
var can_shoot: bool = true


func _ready() -> void:
	_bullet_spawn_timer.wait_time = 60.0 / _rate_of_fire
	_bullet_spawn_timer.one_shot = true
	_bullet_spawn_timer.connect("timeout", self, "_on_bullet_spawn_timer_timeout")


func init(_player: BasePlayer) -> void:
	self.player = _player
	self.position = -player.to_local(_player_attach_point.global_position)


func shoot() -> void:
	if !can_shoot:
		return
	
	var bullet = _bullet_scene.instance()
	player.get_parent().add_child(bullet)
	bullet.init(
		self, 
		player.to_map_coordinates(_bullet_spawn_point.global_position), 
		forward(), 
		_bullet_power, 
		_bullet_speed
	)
	can_shoot = false
	_bullet_spawn_timer.start()


func forward() -> Vector2:
	return player.transform.x


func _on_bullet_spawn_timer_timeout() -> void:
	can_shoot = true
