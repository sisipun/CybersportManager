class_name Hearing
extends Area2D


# warning-ignore:unused_signal
signal detected(position)


func _on_body_entered(body: Node) -> void:
	print('heard')
	emit_signal("detected", body.position)
