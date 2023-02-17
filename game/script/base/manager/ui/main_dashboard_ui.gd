class_name DashboardContainer
extends Control


export (NodePath) onready var _next_day_button = get_node(_next_day_button) as Button
export (NodePath) onready var _day_number_label = get_node(_day_number_label) as Label
export (NodePath) onready var _container = get_node(_container) as Container

export (PackedScene) var player_info_ui_scene: PackedScene
export (PackedScene) var team_info_ui_scene: PackedScene


func _ready() -> void:
	_day_number_label.text = str(Calendar.get_current_date())
	
	var team_info_ui: TeamInfoUi = team_info_ui_scene.instance()
	_container.add_child(team_info_ui)
	team_info_ui.init("0")
	
	assert(Calendar.connect("next_day_started", self, "_on_next_day_started") == OK)
	assert(_next_day_button.connect("pressed", self, "_on_next_day_button_pressed") == OK)


func _on_next_day_started() -> void:
	_day_number_label.text = str(Calendar.get_current_date())


func _on_next_day_button_pressed() -> void:
	Calendar.start_next_day()
