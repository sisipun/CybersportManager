class_name ShootPlayerCommand
extends BasePlayerCommand


func _init(player: TacticalFpsPlayer, current_match: TacticalFpsMatch).(player, current_match) -> void:
	pass


func valid(arguments: Array) -> bool:
	var target: BasePlayer = arguments[0]
	return (
		is_instance_valid(_player)
		and is_instance_valid(target) 
		and is_instance_valid(_player.weapon)
	)


func process(arguments: Array) -> void:
	if not valid(arguments):
		emit_signal("finished")
		return
	
	_player.stop()
	var target: BasePlayer = arguments[0]
	var rotation_finished: bool = false
	while valid(arguments) and not rotation_finished:
		var delta: float = _current_match.get_process_delta_time()
		_player.rotate_to(delta, target.position)
		_player.shoot()
		yield(_current_match.get_tree(), "idle_frame")
	
	emit_signal("finished")
