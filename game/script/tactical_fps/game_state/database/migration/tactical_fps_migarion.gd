class_name TacticalFpsMigration
extends BaseMigration


func get_resource_type() -> String:
	return "TacticalFpsMigration"


func _migrate(file: FileAccess, database: Database) -> void:
	var players: Dictionary = {}
	var players_teams: Dictionary = {}
	var players_current_teams: Dictionary = {}
	var teams: Dictionary = {}
	var organizations: Dictionary = {}
	
	while not file.eof_reached():
		var test_json_conv = JSON.new()
		assert(test_json_conv.parse(file.get_line()) == OK)
		var line = test_json_conv.get_data()
		if line == null:
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
		
		var player_teams: Array = []
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
		players_current_teams[player_data["name"]] = line["stats"]["current_team"]
	
	
	var persist_organizations: Dictionary = {}
	for organization in organizations.values():
		persist_organizations[organization.name] = database.add_model(organization)
	
	var persist_teams: Dictionary = {}
	for team in teams.values():
		persist_teams[team.name] = database.add_model(team)
		team.set_organization(persist_organizations[team.name].get_reference())
	
	var persist_players: Dictionary = {}
	for player in players.values():
		persist_players[player.name] = database.add_model(player)
		if players_current_teams.has(player.name):
			var current_team_name: String = players_current_teams[player.name]
			if persist_teams.has(current_team_name):
				player.set_current_team(persist_teams[current_team_name].get_reference())
