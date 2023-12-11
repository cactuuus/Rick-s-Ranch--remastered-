extends CharacterBody2D

@onready var health : Node2D = $HealthModule
var player : Node2D
@export var max_health : int
@export var attack : int
@export var speed : float

func _physics_process(delta):
	var target = player.global_position
	velocity = global_position.direction_to(target).normalized() * speed * delta
	var collision = move_and_collide(velocity)
	if collision:
		handle_collision(collision)

func _ready():
	health.setup(max_health)
	add_to_group("enemies")

func hit(damage_taken: int):
	health.take_damage(damage_taken)
	if health.is_dead():
		queue_free()

func handle_collision(collision):
	if (collision.get_collider().name == "Player"):
		SignalManager.player_is_hit.emit(attack, velocity)
