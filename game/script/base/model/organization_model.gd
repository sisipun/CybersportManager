class_name OrganizationModel
extends BaseModel


const MODEL_NAME = "Organization"

var name: String
var teams: Array


func _init(
	_name: String
) -> void:
	self.name = _name
	self.teams = []


func get_model_name() -> String:
	return MODEL_NAME
