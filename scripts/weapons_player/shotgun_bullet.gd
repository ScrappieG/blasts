extends CharacterBody2D
class_name Projectile_Shotgun

@export var speed: float = 20.0
@export var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * speed * delta)

	# Handle collision if it occurs
	if collision:
		_on_collision()

func _on_collision() -> void:
	# Handle collision logic
	print("collided")
	queue_free()
