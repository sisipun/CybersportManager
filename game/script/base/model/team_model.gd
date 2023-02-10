class_name TeamModel
extends Resource


export (Discipline.Values) var discipline: int = -1
export (String) var name: String = ""
export (Array, Resource) var players: Array = []

export (String) var _id: String = ""
export (String) var _organization_id: String = ""


func _init(
	_discipline: int,
	_name: String
) -> void:
	self.discipline = _discipline
	self.name = _name


func get_id() -> String:
	return _id


func get_organization() -> OrganizationModel:
	if not _organization_id:
		return null
	
	return Data.get_organization(_organization_id)
