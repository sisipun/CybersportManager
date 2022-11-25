class_name BasePlayer
extends KinematicBody2D


export (NodePath) onready var navigation_agent = get_node(navigation_agent) as NavigationAgent2D
export (NodePath) onready var ray = get_node(ray) as RayCast2D

var team: int = -1
