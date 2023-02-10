class_name TacticalFpsMigration
extends BaseMigration


func _migrate(file: File, database: Database) -> void:
	var players: Dictionary = {}
	var teams: Dictionary = {}
	var organizations: Dictionary = {}
	
	while not file.eof_reached():
		var line = JSON.parse(file.get_line()).result
		if not line:
			continue
		
		var player_data: Dictionary = line["summary"]
		
		if not players.has(player_data["name"]):
			players[player_data["name"]] = PlayerModel.new(
				Discipline.Values.TACTICAL_FPS,
				player_data["name"],
				player_data["real_name"],
				player_data["age"],
				player_data["country"]
			)
		
		var teams_data: Array = player_data["teams"]
		for team_data in teams_data:
			if not teams.has(team_data["name"]):
				teams[team_data["name"]] = TeamModel.new(
					Discipline.Values.TACTICAL_FPS,
					team_data["name"]
				)
				
				organizations[team_data["name"]] = OrganizationModel.new(
					team_data["name"]
				)
	
	for player in players.values():
		var _id: String = database.add_player(player)
	
	for team in teams.values():
		var _id: String = database.add_team(team)
	
	for organization in organizations.values():
		var _id: String = database.add_organization(organization)
