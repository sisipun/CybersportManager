class_name AttackTargetPlayerCommand
extends BasePlayerCommand


func _init(
	player: TacticalFpsPlayer, 
	current_match: TacticalFpsMatch, 
	arguments: Array
) -> void:
	super(player, current_match, arguments)
	pass


func is_valid() -> bool:
	return (
		super()
		and is_instance_valid(_player)
	)


func start() -> void:
	super()
	if not is_valid():
		finish()
		return
	
	var target: Vector2 = _arguments[0]
	_player.move_to(target)
	await _player.navigation_finished
	
	if _player.position == target:
		finish()


func stop() -> void:
	_player.stop()
	super()
