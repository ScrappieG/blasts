extends BaseMob
class_name DemonBat

# Called when the node enters the scene tree for the first time.
@export var projectile_scene: PackedScene
@export var shooting_cooldown: float = 2.0
@onready var animated_sprite = $AnimatedSprite2D
@onready var player = $"../Player"

var is_shooting = false

var cooldown_timer = 0.0

func _ready() -> void:
	animated_sprite.animation = "idle"
	
func _physics_process(_delta: float) -> void:
	cooldown_timer -= _delta
	var player_position = $"../Player".global_position # ref to the player
	
	if is_aggro(player.global_position):
		if cooldown_timer <= 0.0:
			is_shooting = true
			print("Shot at player")
			shoot_at_player()
			cooldown_timer = shooting_cooldown
	else:
		is_shooting = false
	if cooldown_timer > 0.0:
		update_animation(player_position, is_shooting)
	move_towards(player_position,_delta)
	
func shoot_at_player() -> void:
	if not projectile_scene:
		print("Projectile scene not assigned!")
		return
	
	# Instance the projectile
	var projectile = projectile_scene.instantiate()
	
	add_child(projectile)

	# Set projectile position and direction
	projectile.global_position = global_position
	var direction = (player.global_position - global_position).normalized()
	projectile.global_position = global_position + direction * 40.0 #offset
	projectile.direction = direction
	projectile.look_at(player.global_position)

func update_animation(player_position: Vector2, is_shooting: bool) -> void:
	if !(is_aggro(player_position)):
		if animated_sprite.animation != "idle":
			animated_sprite.animation = "idle"
	elif (is_shooting):
		animated_sprite.animation = "attack"
		
	else:
		animated_sprite.animation = "run_left"
		

	if (global_position.x - player_position.x) < 0:
		if animated_sprite.scale.x != -1:
				animated_sprite.scale.x = -1

	elif (global_position.x - player_position.x) >= 0:
		if animated_sprite.scale.x != 1:
			animated_sprite.scale.x = 1
			

func die() -> void:
	animated_sprite.animation = "death"
	queue_free() # deletes the node from the scene
	
func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		die()
	else:
		animated_sprite = "hurt"
