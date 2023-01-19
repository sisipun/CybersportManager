class_name BasePlayerCommand
extends Node


signal finished


var _player: BasePlayer
var _current_match: BaseMatch
var _finished: bool
var _arguments: Array


func _init(
	player: BasePlayer, 
	current_match: BaseMatch, 
	arguments: Array
) -> void:
	self._player = player
	self._current_match = current_match
	self._arguments = arguments
	self._finished = true


func is_valid() -> bool:
	return not _finished


func start() -> void:
	_finished = false


func stop() -> void:
	_finished = true


func finish() -> void:
	stop()
	emit_signal("finished")
