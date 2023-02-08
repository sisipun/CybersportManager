class_name PlayerModel
extends Resource


export (String) var id: String = ""
export (Discipline.Values) var discipline: int = -1
export (String) var name: String = ""
export (String) var real_name: String = ""
export (int) var age: int = 0


func _init(
	_id: String, 
	_discipline: int, 
	_name: String, 
	_real_name: String, 
	_age: int
) -> void:
	self.id = _id
	self.discipline = _discipline
	self.name = _name
	self.real_name = _real_name
	self.age = _age
