class_name TacticalFpsPlayer
extends BasePlayer


export (PackedScene) var bullet_scene: PackedScene = null

var enemy: BasePlayer = null


func _on_enemy_detected(_enemy: KinematicBody2D) -> void:
	if enemy:
		return
	
	stop()
	enemy = _enemy
	shoot()


func _physics_process(delta: float) -> void:
	if enemy:
		.rotate_to(delta, enemy.position)


func shoot() -> void:
	var bullet: TacticalFpsBullet = bullet_scene.instance()
	bullet.init(self, transform.x)
	get_parent().add_child(bullet)
