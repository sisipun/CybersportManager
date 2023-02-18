class_name PlayerInfoUi
extends BaseUi


export (NodePath) onready var _name_label = get_node(_name_label) as Label
export (NodePath) onready var _real_name_label = get_node(_real_name_label) as Label
export (NodePath) onready var _age_label = get_node(_age_label) as Label


func get_type() -> int:
	return Type.PLAYER_INFO


func show_ui(params: Array) -> void:
	var id: String = params[0]
	var player: PlayerModel = Data.get_model(PlayerModel.MODEL_NAME, id)
	
	_name_label.text = str(player.name)
	_real_name_label.text = str(player.real_name)
	_age_label.text = str(player.age)
	
	.show_ui(params)


func hide_ui() -> void:
	.hide_ui()
	
	_name_label.text = ""
	_real_name_label.text = ""
	_age_label.text = ""
