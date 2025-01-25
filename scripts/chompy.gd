extends BaseMob
class_name ChompyMob

# Called when the node enters the scene tree for the first time.

@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.animation = "idle"
	
func _physics_process(_delta: float) -> void:
	var player_position = $"../Player".global_position # ref to the player
	update_animation(player_position)
	move_towards(player_position,_delta)
			
func update_animation(player_position: Vector2) -> void:
	if !(is_aggro(player_position)):
		if animated_sprite.animation != "idle":
			animated_sprite.animation = "idle"
		return
		
	if (global_position.x - player_position.x) < 0:
		if animated_sprite.animation != "run_right" or animated_sprite.scale.x != 1:
			animated_sprite.animation = "run_right"
			animated_sprite.scale.x = 1
			
	elif (global_position.x - player_position.x) >= 0:
		if animated_sprite.animation != "run_right" or animated_sprite.scale.x != -1:
			animated_sprite.animation = "run_right"
			animated_sprite.scale.x = -1
			
