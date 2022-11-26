class_name BasePlayer
extends KinematicBody2D


export (NodePath) onready var navigation_agent = get_node(navigation_agent) as NavigationAgent2D
export (NodePath) onready var vision = get_node(vision) as RayCast2D

var team: int = -1
var player_number: int = -1


func init(team: int, player_number: int) -> void:
	self.team = team
	self.player_number = player_number


func _ready() -> void:
	vision.connect("player_detected", self, "_on_player_detected")


func _on_player_detected(player) -> void:
	if player.team != team:
		print('Enemy detected')
