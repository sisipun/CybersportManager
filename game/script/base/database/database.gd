class_name Database
extends Node


export(Array, Resource) var migrations: Array = []

var organizations: Dictionary = {}
var teams: Dictionary = {}
var players: Dictionary = {}


func _ready() -> void:
	print('Init Database Started')
	
	for migration in migrations:
		migration.migrate(self)
	
	print('Database Inited. Organizations: ', organizations.size(), ', Teams: ', teams.size(), ', Players": ', players.size())


func add_organization(organization: OrganizationModel) -> String:
	organization._id = str(organizations.size())
	organizations[organization.get_id()] = organization
	return organization.get_id()


func add_team(team: TeamModel) -> String:
	team._id = str(teams.size())
	teams[team.get_id()] = team
	return team.get_id()


func add_player(player: PlayerModel) -> String:
	player._id = str(players.size())
	players[player.get_id()] = player
	return player.get_id()


func add_team_to_organization(team_id: String, organization_id: String) -> void:
	if not teams.has(team_id) or not organizations.has(organization_id):
		return
	
	var team: TeamModel = teams[team_id]
	var organization: OrganizationModel = organizations[organization_id]
	if organization.teams.has(team):
		return
	
	team._organization_id = organization_id
	organization.teams.append(team)


func add_player_to_team(player_id: String, team_id: String) -> void:
	if not players.has(player_id) or not teams.has(team_id):
		return
	
	var player: PlayerModel = players[player_id]
	var team: TeamModel = teams[team_id]
	if team.players.has(player):
		return
	
	player._current_team_id = team_id
	team.players.append(player)


func get_organization(id: String) -> OrganizationModel:
	if not organizations.has(id):
		return null
	
	return organizations[id]


func get_team(id: String) -> TeamModel:
	if not teams.has(id):
		return null
	
	return teams[id]


func get_player(id: String) -> PlayerModel:
	if not players.has(id):
		return null
		
	return players[id]
