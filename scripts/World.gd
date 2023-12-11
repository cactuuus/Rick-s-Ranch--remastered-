extends Node2D

const bullet : PackedScene = preload("res://prefabs/Bullet.tscn")

var cooldown : float = 0
@export var spawnrate : float = 1
@export var enemies_on_start : int = 5
@export var enemies : Array[PackedScene]
var spawn_points : Array[Node]

func _ready():
	SignalManager.shot_fired.connect(spawn_bullet)
	spawn_points = $EnemySpawnPoints.get_children()

func _physics_process(delta):
	cooldown += delta
	if (cooldown >= spawnrate):
		spawn_enemy()
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
func spawn_enemy():
	var enemy = enemies.pick_random()
	var spawn_point = spawn_points.pick_random()
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = spawn_point.global_position
	enemy_instance.target = $Player
	add_child(enemy_instance)

