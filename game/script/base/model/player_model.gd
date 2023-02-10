class_name PlayerModel
extends Resource


export (Discipline.Values) var discipline: int = -1
export (String) var name: String = ""
export (String) var real_name: String = ""
export (int) var age: int = 0
export (String) var country: String = ""

export (String) var _id: String = ""
export (String) var _current_team_id: String = ""


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


func get_id() -> String:
	return _id


func get_current_team() -> TeamModel:
	if not _current_team_id:
		return null
	
	return Data.get_team(_current_team_id)
