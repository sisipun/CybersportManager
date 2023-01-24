class_name AttackTargetPlayerCommand
extends BasePlayerCommand


func _init(
	player: TacticalFpsPlayer, 
	current_match: TacticalFpsMatch, 
	arguments: Array
).(player, current_match, arguments) -> void:
	pass


func is_valid() -> bool:
	return (
		.is_valid()
		and is_instance_valid(_player)
	)


func start() -> void:
	.start()
	if not is_valid():
		finish()
		return
	
	var target: Vector2 = arguments[0]
	_player.move_to(target)
	yield(_player, "navigation_finished")
	
	if _player.position == target:
		finish()


func stop() -> void:
	_player.stop()
	.stop()
