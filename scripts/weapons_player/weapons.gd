extends BasePlayer
class_name Weapons

@export var bullets_per_shot: int = 3
@export var fire_rate: float = 1.0
@export var bullet_mult: float = 1.0
@export var kick_back: float = 1.0
var fire_cooldown = 0
var mouse_position = get_global_mouse_position()

func _physics_process(_delta: float) -> void:
	fire_cooldown -= _delta
	mouse_position = get_global_mouse_position()
	velocity = handle_firing()
	update_arrow(mouse_position)
	move_and_slide()

func handle_firing() -> Vector2:
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("left_click"):
		if (fire_cooldown <= 0):
			fire(mouse_position)
			var direction = (mouse_position - global_position).normalized()
			velocity = -direction * kick_back  # Apply kickback in the opposite direction
	update_animation()
	return velocity
	
func update_arrow(mouse_position: Vector2) -> void:
	if mouse_position == null:
		mouse_position = Vector2.ZERO
	var distance_to_mouse = global_position.distance_to(mouse_position)
	var direction = (mouse_position - global_position).normalized()
	var arrow_position = global_position + direction * circle_radius

	if distance_to_mouse > inner_radius:
		if mouse_position != null:
			arrow.look_at(mouse_position)
		look_at(mouse_position)
		arrow.global_position = arrow_position
		
func fire(mouse_position: Vector2) -> void:
	pass
	
	
	
	
	
