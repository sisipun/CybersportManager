class_name TacticalFpsWeapon
extends Sprite


export (NodePath) onready var _bullet_spawn_point = get_node(_bullet_spawn_point) as Node2D
export (NodePath) onready var _player_attach_point = get_node(_player_attach_point) as Node2D

export (PackedScene) var _bullet_scene: PackedScene = null

export (float) var _bullet_power: float = 30.0
export (float) var _bullet_speed: float = 30.0

var player: BasePlayer = null


func init(_player: BasePlayer) -> void:
	self.player = _player
	self.position = -_player_attach_point.position


func shoot() -> void:
	var bullet = _bullet_scene.instance()
	player.get_parent().add_child(bullet)
	bullet.init(self, player.get_parent().to_local(_bullet_spawn_point.global_position), forward(), _bullet_power, _bullet_speed)


func forward() -> Vector2:
	return player.transform.x
