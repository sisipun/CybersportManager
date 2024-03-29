class_name TeamModel
extends BaseModel


const MODEL_NAME: String = "TeamModel"

var discipline: Discipline.Values
var name: String
var players: Array[ModelReference]

var _organization: ModelReference


func _init(
	_discipline: Discipline.Values,
	_name: String
) -> void:
	self.discipline = _discipline
	self.name = _name
	self.players = []


func set_organization(organization: ModelReference) -> void:
	_organization = organization
	get_organization().teams.append(_reference)


func get_organization() -> OrganizationModel:
	if not _organization:
		return null
	
	return _organization.get_value() as OrganizationModel


func get_resource_type() -> String:
	return MODEL_NAME


func get_model_name() -> String:
	return MODEL_NAME
