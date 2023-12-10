extends CharacterBody2D

@export var move_speed : float = 200

@onready var player_sprite : Sprite2D = $PlayerSprite
@onready var health_bar : ProgressBar = $HealthBar
@onready var gun : Node2D = $Gun
var max_health : int = 100
var current_health : float
var isAlive : bool


func _physics_process(_delta):
	# gets input directions (normalized for consistency when moving diagonally)
	var input_direction : Vector2 = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up"),
	).normalized()
	# moves character and updates its facing direction
	velocity = input_direction * move_speed
	move_and_slide()
	update_sprite_direction()


# updates the player's sprite depending on where the gun is pointing to 
func update_sprite_direction():
	player_sprite.flip_h = gun.is_pointing_left()
