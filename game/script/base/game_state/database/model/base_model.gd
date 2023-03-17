class_name BaseModel
extends Resource


const BASE_MODEL_NAME: String = "BaseModel"

var _id: String: get = get_id, set = set_id
var _reference: ModelReference


func set_id(id: String) -> void:
	_id = id
	_reference = ModelReference.new(get_model_name(), _id)


func get_id() -> String:
	return _id


func get_reference() -> ModelReference:
	return _reference


func get_resource_type() -> String:
	return BASE_MODEL_NAME


func get_model_name() -> String:
	return BASE_MODEL_NAME
