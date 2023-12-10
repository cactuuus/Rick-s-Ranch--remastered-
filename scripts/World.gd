extends Node2D

const bullet : PackedScene = preload("res://prefabs/bullet.tscn")

func _ready():
	SignalManager.shot_fired.connect(spawn_bullet)


# spawns a bullet with given position and rotation 
func spawn_bullet(spawn_position, spawn_rotation):
	var bullet_instance = bullet.instantiate()
	bullet_instance.global_rotation = spawn_rotation
	bullet_instance.global_position = spawn_position
	# offets position to spawn on chevron
	bullet_instance.move_local_x(20)
	bullet_instance.add_to_group("bullets")
	add_child(bullet_instance)


# find player
# move towards player
# flip based on direction
# take damage
# destroy if health <= 0
