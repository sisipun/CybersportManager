class_name PlayerInfoUi
extends BaseUi


@export_node_path("Label") var _name_label_path: NodePath
@export_node_path("Label") var _real_name_label_path: NodePath
@export_node_path("Label") var _age_label_path: NodePath

@onready var _name_label: Label = get_node(_name_label_path)
@onready var _real_name_label: Label = get_node(_real_name_label_path)
@onready var _age_label: Label = get_node(_age_label_path)


func get_type() -> int:
	return Type.PLAYER_INFO


func init(params: Array) -> void:
	var id: String = params[0]
	var player: PlayerModel = Data.get_model(PlayerModel.MODEL_NAME, id)
	
	_name_label.text = str(player.name)
	_real_name_label.text = str(player.real_name)
	_age_label.text = str(player.age)
	
	super.init(params)
