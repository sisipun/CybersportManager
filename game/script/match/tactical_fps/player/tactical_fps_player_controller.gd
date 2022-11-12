class_name TacticalFpsPlayerController
extends BasePlayerController


func init(_team: int) -> void:
	.init(_team)


func process(map: BaseMap) -> void:
	var tactical_fps_map: TacticalFpsMap = map as TacticalFpsMap
	var players: Array = map.players[team]
	for player in players:
		var tactical_fps_player: TacticalFpsPlayer = player as TacticalFpsPlayer
		tactical_fps_player.move_to(tactical_fps_map.team_starting_positions[1 - team].position)
