class_name TacticalFpsBullet
extends KinematicBody2D


export (float) var max_speed: float = 100.0
export (float) var power: float = 30.0

var shooter: BasePlayer = null
var direction: Vector2 = Vector2.ZERO


func init(_shooter: BasePlayer, _direction: Vector2) -> void:
	shooter = _shooter
	direction = _direction.normalized()
	position = _shooter.position


func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(direction * max_speed * delta)
	if collision:
		_on_collision(collision.collider)


func _on_collision(collider: CollisionObject2D) -> void:
	if collider == shooter:
		return
	
	if collider is BasePlayer:
		collider.hit(power)
	queue_free()
