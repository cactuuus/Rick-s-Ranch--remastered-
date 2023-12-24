extends CharacterBody2D

@onready var health : Node2D = $HealthModule
@onready var animation_player : AnimationPlayer = $EnemyAnimationPlayer
@onready var sprite : AnimatedSprite2D = $EnemySprite
@onready var cry : AudioStreamPlayer2D = $Cry
@onready var cry_timer : Timer = $CryTimer
var player : Node2D
@export var max_health : int
@export var attack : int
@export var speed : float

func _ready():
	health.setup(max_health)
	add_to_group("enemies")
	cry_timer.set_wait_time(randf_range(0.5, 3))

func _physics_process(_delta):
	var target = player.global_position
	var direction = global_position.direction_to(target).normalized()
	velocity = direction * speed
	update_sprite_direction(direction)
	var collided = move_and_slide()
	if collided:
		handle_collision(get_last_slide_collision())

func update_sprite_direction(direction):
	sprite.scale.x = 1 if direction.x < 0 else -1

func hit(damage_taken: int):
	health.take_damage(damage_taken)
	animation_player.play("hit")
	if health.is_dead():
		queue_free()
		GameManager.enemy_killed.emit()

func handle_collision(collision):
	if (collision.get_collider() == player):
		GameManager.player_is_hit.emit(attack, velocity)

func _on_cry_timer_timeout():
	cry.play()
	cry_timer.set_wait_time(randf_range(3, 5))
