class_name TacticalFpsPlayerController
extends BasePlayerController


var target_plant_zone: TacticalFpsPlantZone = null


func start_round(map: BaseMap) -> void:
	var tactical_fps_map: TacticalFpsMap = map as TacticalFpsMap
	target_plant_zone = tactical_fps_map.plant_zones[randi() % len(tactical_fps_map.plant_zones)]
	var players: Array = map.get_team_players(team)
	for player in players:
		var tactical_fps_player: TacticalFpsPlayer = player as TacticalFpsPlayer
		tactical_fps_player.move_to(target_plant_zone.global_position)


func end_round() -> void:
	target_plant_zone = null
