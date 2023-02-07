class_name BasePlayerController
extends Node


signal player_dead


export (PackedScene) var _player_scene: PackedScene = null

var team: int = -1
var index: int = -1
var _player: BasePlayer = null
var _current_match: BaseMatch = null
var _commands: Array = []
var _current_command: BasePlayerCommand = null


func init(_team: int, _index: int, current_match: BaseMatch) -> void:
	self.team = _team
	self.index = _index
	self._current_match = current_match


func spawn() -> void:
	if _player != null:
		despawn()
	
	_player = _player_scene.instance()
	_player.init(team, index)
	_current_match.map.spawn_player(_player)
	
	assert(_player.connect("saw", self, "_on_player_saw") == OK)
	assert(_player.connect("stopped_seeing", self, "_on_player_stopped_seeing") == OK)
	assert(_player.connect("heard", self, "_on_player_heard") == OK)
	assert(_player.connect("dead", self, "_on_player_dead") == OK)
	assert(_player.connect("hitted", self, "_on_player_hitted") == OK)


func despawn() -> void:
	if _player != null:
		_player.queue_free()
		_player = null


func is_dead() -> bool:
	return _player == null


func _start_command(command: BasePlayerCommand) -> void:
	if _current_command != null:
		_stop_current_command()
	
	_commands.append(command)
	_current_command = command
	assert(_current_command.connect("finished", self, "_on_current_command_finished") == OK)
	_current_command.start()


func _stop_current_command() -> void:
	if _current_command != null:
		_current_command.disconnect("finished", self, "_on_current_command_finished")
		_current_command.stop()
		_current_command = null


func _start_next_command() -> void:
	_stop_current_command()
	_commands.pop_back()
	
	var next_command = _commands.pop_back()
	if next_command != null:
		_start_command(next_command)


func _on_current_command_finished() -> void:
	if not is_dead():
		_start_next_command()


func _on_player_saw(_body: KinematicBody2D) -> void:
	pass


func _on_player_stopped_seeing(_body: KinematicBody2D) -> void:
	pass


func _on_player_heard(_position: Vector2) -> void:
	pass


func _on_player_dead(_killer: BasePlayer) -> void:
	despawn()
	emit_signal("player_dead")


func _on_player_hitted(_hitter: BasePlayer) -> void:
	pass
