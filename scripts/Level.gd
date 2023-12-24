extends Node2D

const bullet : PackedScene = preload("res://scenes/components/Bullet.tscn")

@onready var UI : CanvasLayer = $UI
@onready var pause_screen : Control = $UI/PauseScreen
@onready var death_screen : Control = $UI/DeathScreen
@onready var enemies_left_label : Label = $UI/LevelStats/EnemiesLeft/Label
@onready var animator : AnimationPlayer = $UI/LevelStats/AnimationPlayer
@export var spawnrate : float = 1
@export var enemies : Array[PackedScene]
@export var total_enemies : int
var enemies_spawned : int = 0
var enemies_left : int
var spawn_points : Array[Node]
var cooldown : float = 0

func _ready():
	GameManager.shot_fired.connect(spawn_bullet)
	GameManager.player_is_dead.connect(display_death_screen)
	GameManager.enemy_killed.connect(update_enemies_killed)
	GameManager.pause_toggled.connect(toggle_pause)
	enemies_left = total_enemies
	update_enemies_left_label()
	spawn_points = $EnemySpawnPoints.get_children()
	await level_intro_card()
	for point in spawn_points:
		spawn_enemy(point)

func _physics_process(delta):
	cooldown += delta
	if (cooldown >= spawnrate and enemies_spawned < total_enemies):
		spawn_enemy(spawn_points.pick_random())
		cooldown = 0

# spawns a bullet with given position and rotation 
func spawn_bullet(spawn_position, spawn_rotation, bullet_damage):
	var bullet_instance = bullet.instantiate()
	bullet_instance.global_rotation = spawn_rotation
	bullet_instance.global_position = spawn_position
	bullet_instance.damage = bullet_damage
	# offets position to spawn on chevron
	bullet_instance.move_local_x(20)
	add_child(bullet_instance)

# spawns an enemy
func spawn_enemy(spawn_point: Node2D):
	var enemy = enemies.pick_random()
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = spawn_point.global_position
	enemy_instance.player = $Player
	add_child(enemy_instance)
	enemies_spawned += 1

# displays the death screen
func display_death_screen():
	set_physics_process(false)
	death_screen.visible = true

# "pauses" the level while a little animation (displaying the level name) is played
func level_intro_card():
	set_physics_process(false)
	await $UI/LevelIntro/AnimationPlayer.animation_finished
	$UI/LevelIntro.queue_free()
	set_physics_process(true)

# increment the enemies killed count by one
func update_enemies_killed():
	enemies_left -= 1
	update_enemies_left_label()
	animator.play("font_pulse")
	if (enemies_left == 0):
		GameManager.change_scene("Level 1")

# updates the number in the enemies left label
func update_enemies_left_label():
	enemies_left_label.set_text("%d" % [enemies_left])

# toggles pause the level
func toggle_pause():
	# if physics_processing is false, then either the death screen or the level intro are on
	if is_physics_processing():
		pause_screen.visible = not pause_screen.visible
		get_tree().paused = not get_tree().paused
	
