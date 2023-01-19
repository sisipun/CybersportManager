class_name TacticalFpsPlayerController
extends BasePlayerController


func set_target(target: Vector2) -> void:
	if not is_dead():
		if team == TacticalFpsTeam.Side.BLUE:
			_start_command(DefendTargetPlayerCommand.new(_player, _current_match, [target]))
		else:
			_start_command(AttackTargetPlayerCommand.new(_player, _current_match, [target]))


func start_round() -> void:
	pass


func end_round() -> void:
	_stop_current_command()
	_commands.clear()


func _on_player_hitted(hitter: BasePlayer) -> void:
	_on_enemy_detected(hitter)


func _on_player_player_detected(detected_player: BasePlayer) -> void:
	if detected_player.team != team:
		_on_enemy_detected(detected_player)


func _on_enemy_detected(enemy: BasePlayer) -> void:
	if not is_dead() and not (_current_command is ShootPlayerCommand):
		_start_command(ShootPlayerCommand.new(_player, _current_match, [enemy]))
