class_name ModelReference
extends Resource


var _model_name: String
var _id: String


func get_resource_type() -> String:
	return "ModelReference"


func _init(model_name: String, id: String):
	self._model_name = model_name
	self._id =  id


func get_value() -> BaseModel:
	return Data.get_model(_model_name, _id)
