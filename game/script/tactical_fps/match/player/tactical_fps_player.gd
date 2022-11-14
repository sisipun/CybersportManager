class_name TacticalFpsPlayer
extends BasePlayer


const TARGET_EPSILON: int = 5

export (float) var speed: float = 150.0

var target: Vector2 = Vector2.ZERO
var player_number: int = -1


func init(_team: int, _player_number: int) -> void:
	team = _team
	player_number = _player_number


func _physics_process(_delta: float) -> void:
	var direction: Vector2 = target - position
	if direction.length() > TARGET_EPSILON:
		direction = direction.normalized()
		# warning-ignore:return_value_discarded
		move_and_slide(speed * direction)


func move_to(position: Vector2) -> void:
	target = position
