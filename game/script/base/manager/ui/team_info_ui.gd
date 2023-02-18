class_name TeamInfoUi
extends BaseUi


export (NodePath) onready var _name_label = get_node(_name_label) as Label
export (NodePath) onready var _players_container = get_node(_players_container) as VBoxContainer


func get_type() -> int:
	return Type.TEAM_INFO


func show_ui(params: Array) -> void:
	var id: String = params[0]
	var team: TeamModel = Data.get_model(TeamModel.MODEL_NAME, id)
	
	_name_label.text = str(team.name)
	for player_link in team.players:
		var player_element: LinkButton = LinkButton.new()
		
		_players_container.add_child(player_element)
		var player: PlayerModel = player_link.get_value()
		player_element.text = player.name
		assert(player_element.connect("pressed", self, "_on_player_pressed", [player.get_id()]) == OK)
	
	.show_ui(params)


func hide_ui() -> void:
	.hide_ui()
	_name_label.text = ""
	for child in _players_container.get_children():
		_players_container.remove_child(child)
		child.queue_free()


func _on_player_pressed(id: String) -> void:
	emit_signal("link_pressed", Type.PLAYER_INFO, [id])