class_name TacticalFpsPlayer
extends BasePlayer


var enemy: BasePlayer = null


func _on_enemy_detected(_enemy: KinematicBody2D) -> void:
	stop()
	enemy = _enemy


func _physics_process(delta: float) -> void:
	if enemy:
		.rotate_to(delta, enemy.position)
