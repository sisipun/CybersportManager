class_name Database
extends Node


@export var migrations: Array[Resource] = []

var data: Dictionary = {}


func _ready() -> void:
	print('Init Database Started')
	
	for migration in migrations:
		(migration as BaseMigration).migrate(self)
	
	print(
		'Database Inited. ',
		'Organizations: ', data[OrganizationModel.MODEL_NAME].size(), 
		', Teams: ', data[TeamModel.MODEL_NAME].size(),
		', Players: ', data[PlayerModel.MODEL_NAME].size()
	)


func add_model(model: BaseModel) -> BaseModel:
	var model_name = model.get_model_name()
	if not data.has(model_name):
		data[model_name] = {}
	
	var model_data = data[model_name]
	var model_id = str(model_data.size())
	model.set_id(model_id)
	model_data[model_id] = model
	return model


func get_model(model_name: String, id: String) -> BaseModel:
	if not data.has(model_name) or not data[model_name].has(id):
		return null
	
	return data[model_name][id]
