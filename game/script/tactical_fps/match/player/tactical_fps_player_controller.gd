class_name TacticalFpsPlayerController
extends BasePlayerController


var _target: Vector2 = Vector2.ZERO


func set_target(target: Vector2) -> void:
	if not is_dead():
		_target = target
		_player.move_to(_target)


func _on_player_hitted(hitter: BasePlayer) -> void:
	_on_enemy_detected(hitter)


func _on_player_player_detected(detected_player: BasePlayer) -> void:
	if detected_player.team != team:
		_on_enemy_detected(detected_player)


func _on_enemy_detected(enemy: BasePlayer) -> void:
	if not is_dead() and not _player.shooting_target:
		_player.stop()
		_player.shooting_target = enemy
		assert(enemy.connect("dead", self, "_on_shooting_target_dead") == OK)


func _on_shooting_target_dead(_killer: BasePlayer) -> void:
	if not is_dead():
		_player.shooting_target = null
		_player.move_to(_target)
