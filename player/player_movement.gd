extends CharacterBody2D

@export var move_speed : float = 200

@onready var sprite : Sprite2D = $Sprite2D
@onready var gun : Node2D = $Gun

func _physics_process(_delta):
	# gets input directions (normalized for consistency when moving diagonally)
	var input_direction : Vector2 = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up"),
	).normalized()
	
	update_sprite_direction()
	# update CharacterBody2D velocity and moves the player object
	velocity = input_direction * move_speed
	move_and_slide()
	
	
func update_sprite_direction():
	if gun.is_pointing_left():
		sprite.flip_h = true
	else:
		sprite.flip_h = false


