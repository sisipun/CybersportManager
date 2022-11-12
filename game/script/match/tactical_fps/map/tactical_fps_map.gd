class_name TacticalFpsMap
extends BaseMap


export (Array, Resource) var starting_positions: Array = []
export (int) var players_circle_radius: int = 50

var team_starting_positions: Dictionary = {}


func _ready() -> void:
	for starting_position in starting_positions:
		team_starting_positions[starting_position.team] = starting_position


func get_starting_position(team: int, player_number: int) -> Vector2:
	var y: int = (player_number + 1) * 10 * ((randi() % 2 ) * 2 - 1)
	var x: int = int(sqrt(players_circle_radius * players_circle_radius - y * y)) * ((randi() % 2 ) * 2 - 1)
	var player_offset: Vector2 = Vector2(x, y)
	return team_starting_positions[team].position + player_offset
