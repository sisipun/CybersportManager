class_name TacticalFpsPlayer
extends BasePlayer


func _on_enemy_detected(enemy: KinematicBody2D) -> void:
	look_at(enemy.global_position)
	print('Enemy Detected')
