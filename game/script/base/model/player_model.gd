class_name PlayerModel
extends BaseModel


const MODEL_NAME = "Player"

var discipline: int
var name: String
var real_name: String
var age: int
var country: String

var _current_team: ModelReference


func _init(
	_discipline: int, 
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


func set_current_team(team_id: String) -> void:
	self._current_team = ModelReference.new(TeamModel.MODEL_NAME, team_id)
	if get_current_team():
		get_current_team().players.append(ModelReference.new(MODEL_NAME, _id))


func get_current_team() -> TeamModel:
	if not _current_team:
		return null
	
	return _current_team.get_value() as TeamModel


func get_model_name() -> String:
	return MODEL_NAME
