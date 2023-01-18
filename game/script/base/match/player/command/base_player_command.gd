class_name BasePlayerCommand
extends Node


signal finished


var _player: BasePlayer
var _current_match: BaseMatch


func _init(player: BasePlayer, current_match: BaseMatch) -> void:
	self._player = player
	self._current_match = current_match



func valid(_arguments: Array) -> bool:
	return false


func process(_arguments: Array) -> void:
	pass
