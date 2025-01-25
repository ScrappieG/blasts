extends CharacterBody2D
class_name BaseMob

@export var speed: int = 75 #move speed
@export var health: int = 100 #health
@export var agro_radius: float = 50.0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Mob created")
	initialize_mob()

func initialize_mob() -> void:
	#logic for all mobs (setting and animations and states)
	pass

func move_towards(target_position: Vector2, _delta: float) -> void:
	var direction = (target_position - global_position).normalized() #gets direction of player
	velocity = Vector2.ZERO
	if (is_aggro(target_position)):
		velocity = direction * speed
	move_and_slide()
	
#function that checks if the player is in range to pull agro
func is_aggro(player_position: Vector2) -> bool:
	var distance_to_player = global_position.distance_to(player_position)
	return distance_to_player <= agro_radius
	
#function to allow mobs to take damage
func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		die()

func die() -> void:
	queue_free() # deletes the node from the scene
	
	
		
func update_animation(animated_sprite: AnimatedSprite2D, player_position: Vector2) -> void:
	if !(is_aggro(player_position)):
		if animated_sprite.animation != "idle":
			animated_sprite.animation = "idle"
		return
		
	if (global_position.x - player_position.x) < 0:
		if animated_sprite.animation != "run_right" or animated_sprite.scale.x != 1:
			animated_sprite.animation = "run_right"
			animated_sprite.scale.x = 1
			print("running right")
	elif (global_position.x - player_position.x) >= 0:
		if animated_sprite.animation != "run_right" or animated_sprite.scale.x != -1:
			animated_sprite.animation = "run_right"
			animated_sprite.scale.x = -1
			print("running left")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
