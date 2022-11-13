class_name TacticalFpsStartingPosition
extends BaseStartingPosition


export (TacticalFpsTeam.Side) var team: int = TacticalFpsTeam.Side.RED setget , get_team
export (int) var radius: int = 50


func get_team() -> int:
	return team
