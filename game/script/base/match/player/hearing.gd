class_name Hearing
extends Area2D


signal detected(position)


func _on_body_entered(body: Node) -> void:
	emit_signal("detected", body.position)
