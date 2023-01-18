class_name TacticalFpsPlayerController
extends BasePlayerController


var _target: Vector2 = Vector2.ZERO
var _current_command: BasePlayerCommand = null


func set_target(target: Vector2) -> void:
	if not is_dead():
		_target = target
		_player.move_to(_target)



func start_round() -> void:
	pass


func end_round() -> void:
	_current_command = null


func _on_player_hitted(hitter: BasePlayer) -> void:
	_on_enemy_detected(hitter)


func _on_player_player_detected(detected_player: BasePlayer) -> void:
	if detected_player.team != team:
		_on_enemy_detected(detected_player)


func _on_enemy_detected(enemy: BasePlayer) -> void:
	if not is_dead() and not _current_command:
		_current_command = ShootPlayerCommand.new(_player, _current_match)
		_current_command.process([enemy])
		assert(_current_command.connect("finished", self, "_on_current_command_finished") == OK)


func _on_current_command_finished() -> void:
	if not is_dead():
		_current_command = null
		_player.move_to(_target)
