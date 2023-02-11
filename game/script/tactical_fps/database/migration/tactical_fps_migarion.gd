class_name TacticalFpsMigration
extends BaseMigration


func _migrate(file: File, database: Database) -> void:
	var players: Dictionary = {}
	var players_teams: Dictionary = {}
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
		
		var player_teams:  Array = []
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
			player_teams.append(team_data["name"])
		players_teams[player_data["name"]] = player_teams
	
	
	var organization_name_to_id = {}
	for organization in organizations.values():
		var id: String = database.add_model(organization)
		organization_name_to_id[organization.name] = id
	
	var team_name_to_id = {}
	for team in teams.values():
		var id: String = database.add_model(team)
		team_name_to_id[team.name] = id
		team.set_organization(organization_name_to_id[team.name])
	
	var player_name_to_id = {}
	for player in players.values():
		var id: String = database.add_model(player)
		player_name_to_id[player.name] = id
		if players_teams.has(player.name) and players_teams[player.name].size() > 0:
			var current_team_name: String = players_teams[player.name][0]
			player.set_current_team(team_name_to_id[current_team_name])
