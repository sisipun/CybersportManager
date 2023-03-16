class_name DashboardContainer
extends Control


@export_node_path("Button") var _next_button_path: NodePath
@export_node_path("Button") var _previous_button_path: NodePath
@export_node_path("Button") var _next_day_button_path: NodePath
@export_node_path("Label") var _day_number_label_path: NodePath
@export_node_path("Container") var _container_path: NodePath

@export var _ui_scenes: Array[PackedScene] = []

@onready var _next_button: Button = get_node(_next_button_path)
@onready var _previous_button: Button = get_node(_previous_button_path)
@onready var _next_day_button: Button = get_node(_next_day_button_path)
@onready var _day_number_label: Label = get_node(_day_number_label_path)
@onready var _container: Container = get_node(_container_path)

var _type_to_ui: Dictionary = {}
var _ui_stack: Array[BaseUi] = []
var _current_ui_stack_position: int = -1


func _ready() -> void:
	_day_number_label.text = str(Calendar.get_current_date())
	
	for ui_scene in _ui_scenes:
		var ui: BaseUi = ui_scene.instantiate()
		_type_to_ui[ui.get_type()] = ui_scene
		ui.queue_free()
	
	_on_link_pressed(BaseUi.Type.TEAM_INFO, ["0"])
	
	assert(Calendar.next_day_started.connect(_on_next_day_started) == OK)
	assert(_next_button.pressed.connect(go_next) == OK)
	assert(_previous_button.pressed.connect(go_previous) == OK)
	assert(_next_day_button.pressed.connect(_on_next_day_button_pressed) == OK)


func go_next() -> void:
	_go_to_stack_postion(_current_ui_stack_position + 1)


func go_previous() -> void:
	_go_to_stack_postion(_current_ui_stack_position - 1)


func _go_to_stack_postion(stack_position: int) -> void:
	if 0 > stack_position or stack_position >= _ui_stack.size():
		return
	
	_hide_ui(_ui_stack[_current_ui_stack_position])
	_current_ui_stack_position = stack_position
	_show_ui(_ui_stack[_current_ui_stack_position])


func _show_ui(ui: BaseUi) -> void:
	assert(ui.link_pressed.connect(_on_link_pressed) == OK)
	ui.show()


func _hide_ui(ui: BaseUi) -> void:
	ui.hide()
	ui.link_pressed.disconnect(_on_link_pressed)


func _clear_stack_tail(from: int) -> void:
	while _ui_stack.size() > from:
		var element = _ui_stack.pop_back()
		element.queue_free()


func _on_next_day_started() -> void:
	_day_number_label.text = str(Calendar.get_current_date())


func _on_next_day_button_pressed() -> void:
	Calendar.start_next_day()


func _on_link_pressed(type: int, params: Array) -> void:
	if _current_ui_stack_position >= 0:
		var _current_ui: BaseUi = _ui_stack[_current_ui_stack_position]
		_hide_ui(_current_ui)
	if _current_ui_stack_position + 1 < _ui_stack.size():
		_clear_stack_tail(_current_ui_stack_position + 1)
	
	var _next_ui: BaseUi = _type_to_ui[type].instantiate()
	_ui_stack.append(_next_ui)
	_current_ui_stack_position = _ui_stack.size() - 1
	_container.add_child(_next_ui)
	_next_ui.init(params)
	_show_ui(_next_ui)
