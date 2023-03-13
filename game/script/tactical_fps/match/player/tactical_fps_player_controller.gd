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
	if hitter.team != team:
		_on_enemy_detected(hitter)


func _on_player_saw(body: CharacterBody2D) -> void:
	if body is BasePlayer and body.team != team:
		_on_enemy_detected(body)


func _on_player_stopped_seeing(_body: CharacterBody2D) -> void:
	pass


func _on_player_heard(_position: Vector2) -> void:
	pass


func _on_enemy_detected(enemy: BasePlayer) -> void:
	if not is_dead():
		if not (_current_command is ShootPlayerCommand):
			_start_command(ShootPlayerCommand.new(_player, _current_match, [enemy]))
