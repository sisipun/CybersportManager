class_name TacticalFpsTeamController
extends BaseTeamController


var _target_plant_zone: TacticalFpsPlantZone = null


func start_round() -> void:
	var tactical_fps_map: TacticalFpsMap = _current_match.map as TacticalFpsMap
	_target_plant_zone = tactical_fps_map.plant_zones[randi() % len(tactical_fps_map.plant_zones)]
	var players: Array = tactical_fps_map.get_team_players(_team)
	for player in players:
		var tactical_fps_player: TacticalFpsPlayer = player as TacticalFpsPlayer
		tactical_fps_player.move_to(_target_plant_zone.global_position)


func end_round() -> void:
	_target_plant_zone = null
