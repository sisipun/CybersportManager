class_name PlayerModel
extends BaseModel


const MODEL_NAME: String = "PlayerModel"

var discipline: Discipline.Values
var name: String
var real_name: String
var age: int
var country: String

var _current_team: ModelReference


func _init(
	_discipline: Discipline.Values, 
	_name: String, 
	_real_name: String, 
	_age: int,
	_country: String
) -> void:
	self.discipline = _discipline
	self.name = _name
	self.real_name = _real_name
	self.age = _age
	self.country = _country


func set_current_team(team: ModelReference) -> void:
	_current_team = team
	get_current_team().players.append(_reference)


func get_current_team() -> TeamModel:
	if not _current_team:
		return null
	
	return _current_team.get_value() as TeamModel


func get_resource_type() -> String:
	return MODEL_NAME


func get_model_name() -> String:
	return MODEL_NAME
