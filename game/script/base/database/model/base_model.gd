class_name BaseModel
extends Resource


var _id: String setget set_id, get_id
var _reference: ModelReference


func set_id(id: String) -> void:
	_id = id
	_reference = ModelReference.new(get_model_name(), _id)


func get_id() -> String:
	return _id


func get_reference() -> ModelReference:
	return _reference


func get_model_name() -> String:
	return "Base"
