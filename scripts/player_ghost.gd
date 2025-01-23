extends CharacterBody2D

const SPEED = 300.0
const CIRCLE_RADIUS = 40.0 #distance of cursor from character
const INNER_RADIUS = 50.0 

func _physics_process(_delta: float) -> void:
	velocity = Vector2.ZERO #set velocity to zero at start of frame
	
	# input for horizontal and vertical movement
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1

	# normalize the velocity to ensure consistent speed on the diagnols
	if velocity != Vector2.ZERO:
		velocity = velocity.normalized() * SPEED
		
	var mouse_position = get_global_mouse_position()
	var distance_to_mouse = global_position.distance_to(mouse_position)
	var direction = (mouse_position - global_position).normalized()
	var arrow_position = global_position + direction * CIRCLE_RADIUS
	var arrow = $arrow
	
	if distance_to_mouse > INNER_RADIUS:
		print("Distance to mouse INNNER: ", distance_to_mouse)
		arrow.look_at(mouse_position)
		arrow.global_position = arrow_position
		
		#arrow.look_at(mouse_position)
		
	
	# Move the character.
	move_and_slide()
