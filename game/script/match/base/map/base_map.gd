class_name BaseMap
extends Node


var players: Dictionary = {}


func add_player(player: BasePlayer) -> void:
	if not (players.has(player.team)):
		players[player.team] = []
	
	var team_players: Array = players[player.team]
	var player_position: Vector2 = get_starting_position(player.team, len(team_players))
	player.position = player_position
	player.move_to(player_position)
	add_child(player)
	team_players.append(player)


func get_starting_position(_team: int, _player_number: int) -> Vector2:
	return Vector2.ZERO
