extends Node2D

const bullet : PackedScene = preload("res://bullet/bullet.tscn")
@export var firerate : float = 0.1
var timer : float = 0
var target : Vector2

func _physics_process(delta):
	# points the gun (red chevron) towards the mouse position
	target = get_global_mouse_position()
	look_at(target)
	# check for "shoot" action and firerate
	timer += delta
	if (Input.is_action_just_pressed("shoot") and timer > firerate):
		timer = 0
		shoot(target)

func shoot(target):
	var bullet_instance = bullet.instantiate()
	# sets bullet spawn position and rotation
	bullet_instance.global_rotation = global_rotation
	bullet_instance.move_local_x(40)
	# spawns the bullet as a child of the scene itself
	get_parent().add_child(bullet_instance)
	
func is_pointing_left():
	return global_position.direction_to(target).x < 0
	
