extends BasePlayer
class_name Player_Ghost


func handle_movement() -> Vector2:
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		animated_sprite.animation = "run_right"
		animated_sprite.scale.x = -1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		animated_sprite.animation = "run_right"
		animated_sprite.scale.x = 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	if velocity != Vector2.ZERO:
		velocity = velocity.normalized() * speed
	update_animation()
	return velocity
