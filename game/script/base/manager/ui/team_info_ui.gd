class_name TeamInfoUi
extends BaseUi


@export_node_path("Label") var _name_label_path: NodePath
@export_node_path("VBoxContainer") var _players_container_path: NodePath

@onready var _name_label: Label = get_node(_name_label_path)
@onready var _players_container: VBoxContainer = get_node(_players_container_path)


func get_type() -> int:
	return Type.TEAM_INFO


func init(params: Array) -> void:
	var id: String = params[0]
	var team: TeamModel = Data.get_model(TeamModel.MODEL_NAME, id)
	
	for child in _players_container.get_children():
		child.disconnect("pressed",Callable(self,"_on_player_pressed"))
		_players_container.remove_child(child)
		child.queue_free()
	
	_name_label.text = str(team.name)	
	for player_link in team.players:
		var player_element: LinkButton = LinkButton.new()
		
		_players_container.add_child(player_element)
		var player: PlayerModel = player_link.get_value()
		player_element.text = player.name
		assert(player_element.connect("pressed",Callable(self,"_on_player_pressed").bind(player.get_id())) == OK)
	
	super(params)


func _on_player_pressed(id: String) -> void:
	emit_signal("link_pressed", Type.PLAYER_INFO, [id])
