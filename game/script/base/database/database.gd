class_name Database
extends Node


export(Array, Resource) var migrations: Array = []

var data: Dictionary = {}


func _ready() -> void:
	print('Init Database Started')
	
	for migration in migrations:
		migration.migrate(self)
	
	var player_in_teams: int = 0
	for team in data[TeamModel.MODEL_NAME].values():
		if team.name == "Natus Vincere":
			print(team.players.size())
		
	for team in data[TeamModel.MODEL_NAME].values():
		player_in_teams += team.players.size()
	
	print(
		'Database Inited. ',
		'Organizations: ', data[OrganizationModel.MODEL_NAME].size(), 
		', Teams: ', data[TeamModel.MODEL_NAME].size(),
		', Players: ', data[PlayerModel.MODEL_NAME].size(),
		', Players in teams: ', player_in_teams
	)


func add_model(model: BaseModel) -> String:
	var model_name = model.get_model_name()
	if not data.has(model_name):
		data[model_name] = {}
	
	var model_data = data[model_name]
	var model_id = str(model_data.size())
	model._id = model_id
	model_data[model_id] = model
	return model_id


func get_model(model_name: String, id: String) -> BaseModel:
	if not data.has(model_name) or not data[model_name].has(id):
		return null
	
	return data[model_name][id]
