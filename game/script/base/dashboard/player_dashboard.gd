class_name PlayerDashboard
extends Control


export (NodePath) onready var _name_label = get_node(_name_label) as Label
export (NodePath) onready var _real_name_label = get_node(_real_name_label) as Label
export (NodePath) onready var _age_label = get_node(_age_label) as Label


func init(id: String) -> void:
	var player: PlayerModel = Data.get_model(PlayerModel.MODEL_NAME, id)
	_name_label.text = str(player.name)
	_real_name_label.text = str(player.real_name)
	_age_label.text = str(player.age)
