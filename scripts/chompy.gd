extends BaseMob
class_name ChompyMob

# Called when the node enters the scene tree for the first time.

@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.animation = "idle"
	
func _physics_process(_delta: float) -> void:
	var player_position = $"../Player".global_position # ref to the player
	update_animation(animated_sprite, player_position)
	move_towards(player_position,_delta)
			
		
