class_name TeamModel
extends BaseModel


const MODEL_NAME = "Team"

var discipline: int
var name: String
var players: Array

var _organization: ModelReference


func _init(
	_discipline: int,
	_name: String
) -> void:
	self.discipline = _discipline
	self.name = _name
	self.players = []


func set_organization(organization_id: String) -> void:
	_organization = ModelReference.new(OrganizationModel.MODEL_NAME, organization_id)
	if get_organization():
		get_organization().teams.append(ModelReference.new(MODEL_NAME, _id))


func get_organization() -> OrganizationModel:
	if not _organization:
		return null
	
	return _organization.get_value() as OrganizationModel


func get_model_name() -> String:
	return MODEL_NAME
