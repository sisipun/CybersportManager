class_name BasePlayerController
extends Node


var team: int = -1


func init(_team: int) -> void:
	self.team = _team


func before_start(_map: BaseMap) -> void:
	pass


func process(_map: BaseMap) -> void:
	pass
