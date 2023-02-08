class_name TeamModel
extends Resource


export (String) var id: String = ""
export (Discipline.Values) var discipline: int = -1
export (String) var name: String = ""
export (Array, Resource) var players: Array = []


func _init(
	_id: String,
	_discipline: int,
	_name: String,
	_players: Array
) -> void:
	self.id = _id
	self.discipline = _discipline
	self.name = _name
	self.players = _players
