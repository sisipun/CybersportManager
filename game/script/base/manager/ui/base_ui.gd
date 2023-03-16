class_name BaseUi
extends Control


enum Type {
	PLAYER_INFO,
	TEAM_INFO
}


signal link_pressed(type, params)


func init(_params: Array) -> void:
	pass


func get_type() -> int:
	return -1
