extends Node2D

@export var firerate : float = 0.1
@onready var cooldown : float = 0
var target : Vector2

func _physics_process(delta):
	cooldown += delta
	# points the gun (red chevron) towards the mouse position
	target = get_global_mouse_position()
	look_at(target)
	# checks if player tries to shoot
	if (Input.is_action_just_pressed("shoot") and cooldown > firerate):
		shoot_handler()

# sends a "shot fired" signal and resets the cooldown
func shoot_handler():
	SignalManager.shot_fired.emit(global_position, global_rotation)
	cooldown = 0


# Returns true or false depending on where the player is pointing to
func is_pointing_left():
	return global_position.direction_to(target).x < 0
	
