extends CharacterBody2D

@onready var player_sprite : Sprite2D = $PlayerSprite
@onready var gun : Node2D = $Gun
@onready var health : Node2D = $HealthModule

@export var max_health : int = 100
@export var move_speed : float = 200
@export var knockback_strength : float = 500
var knockback : Vector2 = Vector2.ZERO

func _ready():
	health.setup(max_health)
	SignalManager.player_is_hit.connect(damage_calc)

func _physics_process(_delta):
	print(knockback)
	# gets input directions (normalized for consistency when moving diagonally)
	var input_direction : Vector2 = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up"),
	).normalized()
	# moves character and updates its facing direction
	velocity = input_direction * move_speed + knockback
	move_and_slide()
	knockback = lerp(knockback, Vector2.ZERO, 0.1)
	update_sprite_direction()
	# tries to shoot using its gun
	if (Input.is_action_just_pressed("shoot")):
		gun.shoot_handler()

# updates the player's sprite depending on where the gun is pointing to 
func update_sprite_direction():
	player_sprite.flip_h = gun.is_pointing_left()

# updates player's health, and checks if the player died
func damage_calc(damage: int, enemy_direction: Vector2):
	knockback = enemy_direction.normalized() * knockback_strength
	health.take_damage(damage)
	if health.is_dead():
		remove_child(gun)
		set_physics_process(false)
		print("player is dead")

