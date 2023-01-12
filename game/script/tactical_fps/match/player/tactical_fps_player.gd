class_name TacticalFpsPlayer
extends BasePlayer


export (PackedScene) var _weapon_scene: PackedScene = null

var _enemy: BasePlayer = null
var _target: Vector2 = Vector2.ZERO
var _weapon: TacticalFpsWeapon = null


func _ready() -> void:
	_weapon = _weapon_scene.instance()
	add_child(_weapon)
	_weapon.init(self)


func _physics_process(delta: float) -> void:
	if _enemy:
		.rotate_to(delta, _enemy.position)
		shoot()


func shoot() -> void:
	_weapon.shoot()


func move_to(target: Vector2) -> void:
	.move_to(target)
	_target = target


func _on_enemy_detected(enemy: KinematicBody2D) -> void:
	if _enemy:
		return
	
	stop()
	_enemy = enemy
	assert(_enemy.connect("dead", self, "_on_enemy_dead") == OK)


func _on_enemy_dead() -> void:
	_enemy = null
	move_to(_target)
