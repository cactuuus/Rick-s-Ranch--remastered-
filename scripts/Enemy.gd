extends CharacterBody2D

@onready var health : Node2D = $HealthModule

var target : Node2D
@export var max_health : int
@export var attack_damage : int
@export var speed : float

func _ready():
	health.setup(max_health)
	add_to_group("enemies")

func hit(damage_taken: int):
	health.take_damage(damage_taken)
	if health.is_dead():
		queue_free()
