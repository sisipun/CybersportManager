class_name TeamModel
extends Resource


export (String) var id: String = ""
export (Discipline.Values) var discipline: int = -1
export (String) var name: String = ""
export (Array, Resource) var players: Array = []

export (String) var _organization_id: String = ""


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
	for player in players:
		player.set_current_team_id(id)


func set_organization_id(organization_id: String) -> void:
	self._organization_id = organization_id


func get_organization() -> OrganizationModel:
	if not _organization_id:
		return null
	
	return Database.get_organization()
