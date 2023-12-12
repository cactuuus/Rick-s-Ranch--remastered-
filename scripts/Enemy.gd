extends CharacterBody2D

@onready var health : Node2D = $HealthModule
@onready var animation_player : AnimationPlayer = $EnemyAnimationPlayer
@onready var sprite : AnimatedSprite2D = $EnemySprite
var player : Node2D
@export var max_health : int
@export var attack : int
@export var speed : float

func _ready():
	health.setup(max_health)
	add_to_group("enemies")

func _physics_process(delta):
	var target = player.global_position
	var direction = global_position.direction_to(target).normalized()
	velocity = direction * speed * delta
	update_sprite_direction(direction)
	var collision = move_and_collide(velocity)
	if collision:
		handle_collision(collision)

func update_sprite_direction(direction):
	sprite.flip_h = ceil(direction.x)
	

func hit(damage_taken: int):
	health.take_damage(damage_taken)
	animation_player.play("hit")
	if health.is_dead():
		queue_free()

func handle_collision(collision):
	if (collision.get_collider() == player):
		SignalManager.player_is_hit.emit(attack, velocity)
