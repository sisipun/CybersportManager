extends Node


var organizations: Dictionary = {}
var teams: Dictionary = {}
var players: Dictionary = {}


func _ready() -> void:
	print('Init Database Started')
	
	var player: PlayerModel = PlayerModel.new(
		"1",
		Discipline.Values.TACTICAL_FPS,
		"s1mple",
		"Alex Kostylev",
		25
	)
	players[player.id] = player
	
	var team: TeamModel = TeamModel.new(
		"1", 
		Discipline.Values.TACTICAL_FPS, 
		"NaVi CS:GO", 
		[player]
	)
	teams[team.id] = team
	
	var organization: OrganizationModel = OrganizationModel.new(
		"1",
		"NaVi",
		[team]
	)
	organizations[organization.id] = organization
	
	print('Database Inited')
	


func get_organization(id: String) -> OrganizationModel:
	return organizations[id]


func get_team(id: String) -> TeamModel:
	return teams[id]


func get_player(id: String) -> PlayerModel:
	return players[id]
