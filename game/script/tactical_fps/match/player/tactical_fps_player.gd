class_name TacticalFpsPlayer
extends BasePlayer


export (PackedScene) var _weapon_scene: PackedScene = null

var shooting_target: BasePlayer = null
var _weapon: TacticalFpsWeapon = null


func _ready() -> void:
	_weapon = _weapon_scene.instance()
	add_child(_weapon)
	_weapon.init(self)


func _physics_process(delta: float) -> void:
	if is_instance_valid(shooting_target):
		.rotate_to(delta, shooting_target.position)
		shoot()


func shoot() -> void:
	_weapon.shoot()
