class_name BaseTeamController
extends Node


signal team_dead(team)


var _team: int = -1
var _current_match: BaseMatch = null
var _players: Array = []


func init(team: int, players: Array, current_match: BaseMatch) -> void:
	self._team = team
	self._current_match = current_match
	self._players = players
	for player in _players:
		assert(player.connect("player_dead", self, "_on_player_dead") == OK)


func before_start() -> void:
	pass


func process() -> void:
	pass


func _on_player_dead() -> void:
	for player in _players:
		if not player.is_dead():
			return
	
	emit_signal("team_dead", _team)
