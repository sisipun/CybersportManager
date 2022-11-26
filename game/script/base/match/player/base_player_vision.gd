class_name BasePlayerVision
extends RayCast2D


signal player_detected(player)


func _physics_process(delta: float) -> void:
	if is_colliding() and get_collider() is BasePlayer:
		emit_signal("player_detected", get_collider())
