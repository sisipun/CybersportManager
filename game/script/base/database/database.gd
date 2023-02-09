extends Node


var organizations: Dictionary = {}
var teams: Dictionary = {}
var players: Dictionary = {}

var _data_path: String = "res://asset/data/"
var _data_file: String = "data.jsonl"


func _ready() -> void:
	print('Init Database Started')
	
	var file = File.new()
	if not file.file_exists(_data_path + _data_file):
		print('Database file not exists')
		return
	
	file.open(_data_path + _data_file, File.READ)
	while not file.eof_reached():
		pass
	file.close()
	
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
