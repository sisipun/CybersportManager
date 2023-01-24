class_name BasePlayerCommand
extends Node


signal finished


var _player: BasePlayer
var _current_match: BaseMatch
var finished: bool
var arguments: Array


func _init(
	player: BasePlayer, 
	current_match: BaseMatch, 
	_arguments: Array
) -> void:
	self._player = player
	self._current_match = current_match
	self.arguments = _arguments
	self.finished = true


func is_valid() -> bool:
	return not finished


func start() -> void:
	finished = false


func stop() -> void:
	finished = true


func finish() -> void:
	stop()
	emit_signal("finished")
