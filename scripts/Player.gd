extends CharacterBody2D

@onready var player_sprite : Sprite2D = $PlayerSprite
@onready var gun : Node2D = $Gun
@onready var health : Node2D = $HealthModule
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var hit_sound : AudioStreamPlayer = $Hit

@export var max_health : int = 100
@export var move_speed : float = 200
@export var knockback_strength : float = 500
var knockback : Vector2 = Vector2.ZERO

func _ready():
	health.setup(max_health)
	GameManager.player_is_hit.connect(damage_calc)

func _physics_process(_delta):
	move_player()
	update_sprite_direction()
	# tries to shoot using its gun
	if (Input.is_action_just_pressed("shoot")):
		gun.shoot_handler()

# updates the player's sprite depending on where the gun is pointing to 
func update_sprite_direction():
	player_sprite.flip_h = gun.is_pointing_left()

# updates player's health, and checks if the player died
func damage_calc(damage: int, enemy_direction: Vector2):
	if not health.is_dead():
		hit_sound.play()
		knockback = enemy_direction.normalized() * knockback_strength
		animation_tree.set("parameters/BlendTree/PlayerHit/request", 1)
		health.take_damage(damage)
		if health.is_dead():
			gun.queue_free()
			set_physics_process(false)
			GameManager.player_is_dead.emit()

# moves the character based on the player's input
func move_player():
	# gets input directions (normalized for consistency when moving diagonally)
	var input_direction : Vector2 = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up"),
	).normalized()
	update_velocity(input_direction)
	move_and_slide()

# updates the player's velocity based on the input, move_speed and knockback
func update_velocity(input_direction):
	velocity = input_direction * move_speed
	if knockback:
		velocity += knockback
		knockback = lerp(knockback, Vector2.ZERO, 0.1)
	

