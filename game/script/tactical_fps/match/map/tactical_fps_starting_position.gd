class_name TacticalFpsStartingPosition
extends BaseStartingPosition


@export var team: TacticalFpsTeam.Side = TacticalFpsTeam.Side.RED : get = get_team
@export var radius: int = 50


func get_team() -> int:
	return team
