class_name ModelReference
extends Resource


export (String) var _model_name: String
export (String) var _id: String


func _init(model_name: String, id: String) -> void:
	self._model_name = model_name
	self._id =  id


func get_value() -> BaseModel:
	return Data.get_model(_model_name, _id)
