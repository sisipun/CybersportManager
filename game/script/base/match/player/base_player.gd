class_name BasePlayer
extends KinematicBody2D


export (NodePath) onready var navigation_agent = get_node(navigation_agent) as NavigationAgent2D

var team: int = -1
