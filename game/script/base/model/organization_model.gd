class_name OrganizationModel
extends Resource


export (String) var name: String = ""
export (Array, Resource) var teams: Array = []

export (String) var _id: String = ""


func _init(
	_name: String
) -> void:
	self.name = _name


func get_id() -> String:
	return _id
