class_name TacticalFpsPlayer
extends BasePlayer


export (PackedScene) var _weapon_scene: PackedScene = null

var _enemy: BasePlayer = null
var _weapon: TacticalFpsWeapon = null


func _ready() -> void:
	_weapon = _weapon_scene.instance()
	add_child(_weapon)
	_weapon.init(self)


func _on_enemy_detected(enemy: KinematicBody2D) -> void:
	if _enemy:
		return
	
	stop()
	_enemy = enemy


func _physics_process(delta: float) -> void:
	if _enemy:
		.rotate_to(delta, _enemy.position)
		shoot()


func shoot() -> void:
	_weapon.shoot()
