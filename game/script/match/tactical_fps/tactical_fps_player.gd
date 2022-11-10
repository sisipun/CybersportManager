class_name TacticalFpsPlayer
extends KinematicBody2D


const TARGET_EPSILON = 5

export (float) var speed: float = 150.0

var target: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var direction: Vector2 = target - position
	if direction.length() > TARGET_EPSILON:
		direction = direction.normalized()
		move_and_slide(speed * direction)


func move_to(position: Vector2) -> void:
	target = position
