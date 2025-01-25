extends CharacterBody2D


@export var speed: float = 100.0
@export var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * speed * delta)

	# Handle collision if it occurs
	if collision:
		_on_collision(collision)

func _on_collision(collision: KinematicCollision2D) -> void:
	# Handle collision logic
	queue_free()
