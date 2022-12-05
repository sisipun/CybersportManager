class_name TacticalFpsMap
extends BaseMap


signal team_dead


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


func get_starting_position(player: BasePlayer) -> Vector2:
	var starting_position = team_starting_positions[player.team]
	var radius = starting_position.radius
	var y: int = (player.player_number + 1) * 10 * ((randi() % 2 ) * 2 - 1)
	var x: int = int(sqrt(radius * radius - y * y)) * ((randi() % 2 ) * 2 - 1)
	var player_offset: Vector2 = Vector2(x, y)
	return starting_position.position + player_offset


func _on_player_dead(player: BasePlayer) -> void:
	players[player.team].erase(player)
	if players[player.team] == []:
		emit_signal("team_dead")


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		players[0][0].move_to(event.position)



func _on_body_exited(body: Node) -> void:
	body.queue_free()
