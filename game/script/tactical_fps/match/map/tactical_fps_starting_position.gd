class_name TacticalFpsStartingPosition
extends BaseStartingPosition


@export (TacticalFpsTeam.Side) var team: int = TacticalFpsTeam.Side.RED : get = get_team
@export (int) var radius: int = 50


func get_team() -> int:
	return team
