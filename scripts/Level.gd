extends Node2D

const bullet : PackedScene = preload("res://scenes/components/Bullet.tscn")

@onready var UI : CanvasLayer = $UI
@onready var pause_screen : Control = $UI/PauseScreen
@onready var death_screen : Control = $UI/DeathScreen
@onready var level_stats : Control = $UI/LevelStats
@export var enemies : Array[PackedScene]
@export var total_enemies : int
var enemies_spawned : int = 0
var enemies_left : int
var spawn_points : Array[Node]

func _ready():
	GameManager.shot_fired.connect(spawn_bullet)
	GameManager.player_is_dead.connect(display_death_screen)
	GameManager.enemy_killed.connect(update_enemies_killed)
	GameManager.pause_toggled.connect(toggle_pause)
	enemies_left = total_enemies
	level_stats.update_enemies_left_label(enemies_left, false)
	spawn_points = $EnemySpawnPoints.get_children()
	await play_level_intro()
	for spawn_point in spawn_points:
		spawn_enemy(spawn_point)

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
func play_level_intro():
	set_physics_process(false)
	await $UI/LevelIntro/AnimationPlayer.animation_finished
	$UI/LevelIntro.queue_free()
	set_physics_process(true)

# increment the enemies killed count by one
func update_enemies_killed():
	enemies_left -= 1
	level_stats.update_enemies_left_label(enemies_left)
	if (enemies_left == 0):
		GameManager.next_level()

# toggles pause the level
func toggle_pause():
	# if physics_processing is false, then either the death screen or the level intro are on
	if is_physics_processing():
		pause_screen.visible = not pause_screen.visible
		get_tree().paused = not get_tree().paused
	
# on timeout spawns an enemy
func _on_spawnrate_timeout():
	if enemies_spawned < total_enemies:
		spawn_enemy(spawn_points.pick_random())
