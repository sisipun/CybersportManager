class_name ShootPlayerCommand
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
		and is_instance_valid(_arguments[0]) 
		and is_instance_valid(_player.weapon)
		and (not _player.is_rotated_to(_arguments[0].position) or _player.can_see(_arguments[0]))
	)


func start() -> void:
	super()
	if not is_valid():
		finish()
		return
	
	_player.stop()
	var target: BasePlayer = _arguments[0]
	while is_valid():
		var delta: float = _current_match.get_process_delta_time()
		_player.rotate_to(delta, target.position)
		_player.shoot()
		await _current_match.get_tree().process_frame
	
	finish()
