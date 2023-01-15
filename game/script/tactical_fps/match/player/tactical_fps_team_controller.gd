class_name TacticalFpsTeamController
extends BaseTeamController


func start_round() -> void:
	var tactical_fps_map: TacticalFpsMap = _current_match.map as TacticalFpsMap
	var _target_plant_zone: TacticalFpsPlantZone = tactical_fps_map.plant_zones[randi() % len(tactical_fps_map.plant_zones)]
	for player in _players:
		var tactical_fps_player: TacticalFpsPlayerController = player as TacticalFpsPlayerController
		tactical_fps_player.set_target(_target_plant_zone.global_position)


func end_round() -> void:
	pass
