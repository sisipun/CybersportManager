class_name OrganizationModel
extends Resource


export (String) var id: String = ""
export (String) var name: String = ""
export (Array, Resource) var teams: Array = []


func _init(
	_id: String, 
	_name: String, 
	_teams: Array
) -> void:
	self.id = _id
	self.name = _name
	self.teams = _teams
	for team in teams:
		team.set_organization_id(id)
