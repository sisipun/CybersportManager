class_name DashboardContainer
extends Control


export (NodePath) onready var _next_day_button = get_node(_next_day_button) as Button
export (NodePath) onready var _day_number_label = get_node(_day_number_label) as Label
export (NodePath) onready var _container = get_node(_container) as Container

export (Array, PackedScene) var _ui_scenes: Array = []

var _type_to_ui: Dictionary = {}
var _current_ui: BaseUi = null


func _ready() -> void:
	_day_number_label.text = str(Calendar.get_current_date())
	
	for ui_scene in _ui_scenes:
		var ui: BaseUi = ui_scene.instance()
		_type_to_ui[ui.get_type()] = ui_scene
		ui.queue_free()
	
	_on_link_pressed(BaseUi.Type.TEAM_INFO, ["0"])
	
	assert(Calendar.connect("next_day_started", self, "_on_next_day_started") == OK)
	assert(_next_day_button.connect("pressed", self, "_on_next_day_button_pressed") == OK)


func _on_next_day_started() -> void:
	_day_number_label.text = str(Calendar.get_current_date())


func _on_next_day_button_pressed() -> void:
	Calendar.start_next_day()


func _on_link_pressed(type: int, params: Array) -> void:
	if _current_ui:
		_current_ui.hide_ui()
		_current_ui.disconnect("link_pressed", self, "_on_link_pressed")
		_current_ui.queue_free()
	
	_current_ui = _type_to_ui[type].instance()
	_container.add_child(_current_ui)
	assert(_current_ui.connect("link_pressed", self, "_on_link_pressed") == OK)
	_current_ui.show_ui(params)
