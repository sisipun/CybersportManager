class_name ShootPlayerCommand
extends BasePlayerCommand


func _init(
	player: TacticalFpsPlayer, 
	current_match: TacticalFpsMatch, 
	arguments: Array
).(player, current_match, arguments) -> void:
	pass


func is_valid() -> bool:
	var target: BasePlayer = _arguments[0]
	return (
		.is_valid()
		and is_instance_valid(_player)
		and is_instance_valid(target) 
		and is_instance_valid(_player.weapon)
	)


func start() -> void:
	.start()
	if not is_valid():
		finish()
		return
	
	_player.stop()
	var target: BasePlayer = _arguments[0]
	var rotation_finished: bool = false
	while is_valid() and not rotation_finished:
		var delta: float = _current_match.get_process_delta_time()
		_player.rotate_to(delta, target.position)
		_player.shoot()
		yield(_current_match.get_tree(), "idle_frame")
	
	finish()
