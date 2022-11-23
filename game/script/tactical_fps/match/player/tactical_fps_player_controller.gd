class_name TacticalFpsPlayerController
extends BasePlayerController


var target_plant_zone: TacticalFpsPlantZone = null


func init(_team: int) -> void:
	team = _team


func before_start(map: BaseMap) -> void:
	var tactical_fps_map: TacticalFpsMap = map as TacticalFpsMap
	if not target_plant_zone:
		target_plant_zone = tactical_fps_map.plant_zones[randi() % len(tactical_fps_map.plant_zones)]
	var players: Array = map.players[team]
	for player in players:
		var tactical_fps_player: TacticalFpsPlayer = player as TacticalFpsPlayer
		tactical_fps_player.move_to(target_plant_zone)
