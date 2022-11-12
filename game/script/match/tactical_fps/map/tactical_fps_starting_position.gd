class_name TacticalFpsStartingPosition
extends BaseStartingPosition


export (TacticalFpsTeam.Side) var team: int = TacticalFpsTeam.Side.RED setget , get_team


func get_team() -> int:
	return team
