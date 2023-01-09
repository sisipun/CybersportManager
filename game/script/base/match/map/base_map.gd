class_name BaseMap
extends Node


export (NodePath) onready var _navigation = get_node(_navigation) as Navigation2D

var _players: Dictionary = {}


func add_player(player: BasePlayer) -> void:
	if not (_players.has(player.team)):
		_players[player.team] = []
	
	assert(player.connect("dead", self, "_on_player_dead", [player]) == OK)
	
	var team_players: Array = _players[player.team]
	var player_position: Vector2 = get_starting_position(player)
	player.position = player_position
	_navigation.add_child(player)
	team_players.append(player)


func get_starting_position(_player: BasePlayer) -> Vector2:
	return Vector2.ZERO


func clear() -> void:
	for team_players in _players.values():
		for player in team_players:
			player.queue_free()
	_players.clear()


func get_team_players(team: int) -> Array:
	if team < _players.size():
		return _players[team]
	else: 
		return []


func _on_player_dead(_player: BasePlayer) -> void:
	pass
