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
	_on_player_detected([hitter])


func _on_player_detected(bodies: Array) -> void:
	var enemies: Array = []
	for body in bodies:
		if body.team != team:
			enemies.append(body)
	
	_on_enemy_detected(enemies)


func _on_enemy_detected(enemies: Array) -> void:
	if not is_dead():
		if not (_current_command is ShootPlayerCommand):
			if enemies.size() > 0:
				_start_command(ShootPlayerCommand.new(_player, _current_match, [enemies[0]]))
