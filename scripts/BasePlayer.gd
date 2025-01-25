extends CharacterBody2D
class_name BasePlayer

#Allows us to change these variables in the inspector (menu on right)
@export var speed: int = 150
@export var circle_radius: float = 20
@export var inner_radius: float = 25.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var arrow: Node2D = $arrow

# Called when the node enters the scene tree for the first time.
func _physics_process(_delta: float) -> void:
	velocity = handle_movement()
	update_arrow()
	move_and_slide()

#throw away function to be overwritten in derived class
func handle_movement() -> Vector2: 
	velocity = Vector2.ZERO
	return velocity

# Update the arrow logic (if used)
func update_arrow() -> void:
	var mouse_position = get_global_mouse_position()
	if mouse_position == null:
		mouse_position = Vector2.ZERO
	var distance_to_mouse = global_position.distance_to(mouse_position)
	var direction = (mouse_position - global_position).normalized()
	var arrow_position = global_position + direction * circle_radius

	if distance_to_mouse > inner_radius:
		arrow.look_at(mouse_position)
		arrow.global_position = arrow_position

# Manage animations
func update_animation() -> void:
	if velocity == Vector2.ZERO:
		if animated_sprite.animation != "idle":
			animated_sprite.animation = "idle"
			animated_sprite.scale.x = 1
	else:
		if velocity.x > 0:
			animated_sprite.animation = "run_right"
			animated_sprite.scale.x = 1
		elif velocity.x < 0:
			animated_sprite.animation = "run_right"
			animated_sprite.scale.x = -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
