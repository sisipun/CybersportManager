class_name BaseUi
extends Control


enum Type {
	PLAYER_INFO,
	TEAM_INFO
}


# warning-ignore:unused_signal
signal link_pressed(type, params)


func show_ui(_params: Array) -> void:
	self.show()


func hide_ui() -> void:
	self.hide()


func get_type() -> int:
	return -1
