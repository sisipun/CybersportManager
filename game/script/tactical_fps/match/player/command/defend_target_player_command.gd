class_name DefendTargetPlayerCommand
extends BasePlayerCommand


func _init(
	player: TacticalFpsPlayer, 
	current_match: TacticalFpsMatch, 
	arguments: Array
).(player, current_match, arguments) -> void:
	pass


func is_valid() -> bool:
	return (
		super.is_valid()
		and is_instance_valid(_player)
	)


func start() -> void:
	super.start()
	if not is_valid():
		finish()
		return
	
	var target: Vector2 = arguments[0]
	_player.move_to(target)
	await _player.navigation_finished
	
	if _player.position == target:
		finish()


func stop() -> void:
	if is_instance_valid(_player):
		_player.stop()
	super.stop()
