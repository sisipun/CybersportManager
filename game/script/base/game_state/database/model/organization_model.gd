class_name OrganizationModel
extends BaseModel


const MODEL_NAME: String = "OrganizationModel"

var name: String
var teams: Array[ModelReference]


func _init(
	_name: String
) -> void:
	self.name = _name
	self.teams = []


func get_resource_type() -> String:
	return MODEL_NAME


func get_model_name() -> String:
	return MODEL_NAME
