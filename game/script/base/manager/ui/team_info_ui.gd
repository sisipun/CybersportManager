class_name TeamInfoUi
extends Control


export (NodePath) onready var _name_label = get_node(_name_label) as Label
export (NodePath) onready var _players_container = get_node(_players_container) as VBoxContainer


func init(id: String) -> void:
	var team: TeamModel = Data.get_model(TeamModel.MODEL_NAME, id)
	_name_label.text = str(team.name)
	for child in _players_container.get_children():
		_players_container.remove_child(child)
		child.queue_free()
	for player in team.players:
		var player_element: Label = Label.new()
		_players_container.add_child(player_element)
		player_element.text = player.get_value().name
