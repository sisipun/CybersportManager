class_name TacticalFpsMap
extends BaseMap


export (Array, NodePath) var starting_position_nodes: Array = []
export (Array, NodePath) var plant_zone_nodes: Array = []

var team_starting_positions: Dictionary = {}
var plant_zones: Array = []


func _ready() -> void:
	for starting_position_node in starting_position_nodes:
		var starting_position: TacticalFpsStartingPosition = get_node(starting_position_node)
		team_starting_positions[starting_position.team] = starting_position
	
	for plant_zone_node in plant_zone_nodes:
		plant_zones.append(get_node(plant_zone_node))


func get_starting_position(team: int, player_number: int) -> Vector2:
	var starting_position = team_starting_positions[team]
	var radius = starting_position.radius
	var y: int = (player_number + 1) * 10 * ((randi() % 2 ) * 2 - 1)
	var x: int = int(sqrt(radius * radius - y * y)) * ((randi() % 2 ) * 2 - 1)
	var player_offset: Vector2 = Vector2(x, y)
	return team_starting_positions[team].position + player_offset
