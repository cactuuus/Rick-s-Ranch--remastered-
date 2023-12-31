extends Node2D

@export var firerate : float = 0.1
@export var damage : int = 10
@onready var gunshot_sound : AudioStreamPlayer = $Gunshot
var cooldown : float = 0
var target : Vector2

func _physics_process(delta):
	cooldown += delta
	# points the gun (red chevron) towards the mouse position
	target = get_global_mouse_position()
	look_at(target)

# if player can shoot, sends a "shot fired" signal and resets the cooldown
func shoot_handler():
	if (cooldown > firerate):
		GameManager.shot_fired.emit(global_position, global_rotation, damage)
		gunshot_sound.play()
		cooldown = 0

# Returns true or false depending on where the player is pointing to
func is_pointing_left():
	return global_position.direction_to(target).x < 0
	
