class_name TacticalFpsBullet
extends KinematicBody2D


var _weapon: TacticalFpsWeapon = null
var _direction: Vector2 = Vector2.ZERO
var _power: float = 0.0 
var _speed: float = 0.0 


func init(
	weapon: TacticalFpsWeapon, 
	position: Vector2, 
	direction: Vector2, 
	power: float, 
	speed: float
) -> void:
	self._weapon = weapon
	self._direction = direction.normalized()
	self._power = power
	self._speed = speed
	self.position = position


func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(_direction * _speed * delta)
	if collision:
		_on_collision(collision.collider)


func _on_collision(collider: CollisionObject2D) -> void:
	if collider == _weapon.player:
		return
	
	if collider is TacticalFpsPlayer:
		collider.hit(_power)
	queue_free()
