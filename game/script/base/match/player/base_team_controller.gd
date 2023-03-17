class_name BaseTeamController
extends Node


signal team_dead(team)


var _team: int = -1
var _current_match: BaseMatch = null
var _players: Array[BasePlayerController] = []


func init(team: int, players: Array[BasePlayerController], current_match: BaseMatch) -> void:
	self._team = team
	self._current_match = current_match
	self._players = players
	for player in _players:
		assert(player.player_dead.connect(_on_player_dead) == OK)


func before_start() -> void:
	pass


func process() -> void:
	pass


func _on_player_dead() -> void:
	if _players.all(func(player) -> bool: return player.is_dead()):
		emit_signal("team_dead", _team)
