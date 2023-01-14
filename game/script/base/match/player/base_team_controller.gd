class_name BaseTeamController
extends Node


var _team: int = -1
var _current_match: BaseMatch = null


func init(team: int, current_match: BaseMatch) -> void:
	self._team = team
	self._current_match = current_match


func before_start() -> void:
	pass


func process() -> void:
	pass
