class_name BasePlayerController
extends Node


signal player_dead


export (PackedScene) var _player_scene: PackedScene = null

var team: int = -1
var index: int = -1
var _player: BasePlayer = null
var _current_match: BaseMatch = null


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
	
	assert(_player.connect("dead", self, "_on_player_dead") == OK)
	assert(_player.connect("player_detected", self, "_on_player_player_detected") == OK)


func despawn() -> void:
	if _player != null:
		_player.queue_free()
		_player = null


func is_dead() -> bool:
	return _player == null


func _on_player_dead() -> void:
	despawn()
	emit_signal("player_dead")


func _on_player_player_detected(_detected_player: BasePlayer) -> void:
	pass
