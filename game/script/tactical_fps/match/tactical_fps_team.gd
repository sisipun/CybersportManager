class_name TacticalFpsTeam
extends Node


enum Side {
	RED,
	BLUE
}

static func all_sides() -> Array[TacticalFpsTeam.Side]:
	return [TacticalFpsTeam.Side.RED, TacticalFpsTeam.Side.BLUE]
