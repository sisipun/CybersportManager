class_name TacticalFpsPlayer
extends BasePlayer


@export var _weapon_scene: PackedScene = null

var weapon: TacticalFpsWeapon = null


func _ready() -> void:
	super()
	weapon = _weapon_scene.instantiate()
	add_child(weapon)
	weapon.init(self)


func shoot() -> void:
	weapon.shoot()
