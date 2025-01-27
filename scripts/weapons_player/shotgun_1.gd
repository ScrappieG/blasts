extends Weapons

@export var projectile_scene: PackedScene
@export var bullet_spread: int = 15 # angle
func fire(mouse_position: Vector2):
	if not projectile_scene:
		print("Projectile scene not assigned!")
		return
	var base_direction = (mouse_position - global_position).normalized()
	
	var angle_step = bullet_spread / bullets_per_shot
	var initial_angle_offset = -(bullet_spread / 2) #center of the spread
	
	for i in range(bullets_per_shot):
		#calculate the angle for this bullet
		var angle_offset = initial_angle_offset + (i * angle_step)
		var bullet_direction = base_direction.rotated(deg_to_rad(angle_offset))
		
		var bullet = projectile_scene.instantiate()
		get_parent().add_child(bullet)
		var spawn_location = global_position + bullet_direction * 40.0 #offset
		bullet.global_position = spawn_location
		bullet.direction = bullet_direction * bullet_mult
		
	fire_cooldown = 1.0
	
