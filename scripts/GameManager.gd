extends Node

signal shot_fired(spawn_position: Vector2, rotation: float, bullet_damage: int)
signal player_is_hit(damage: int, enemy_direction: Vector2)
signal player_is_dead()
signal enemy_killed()
signal input_key_updated(action_name: String)
signal reset_input_keys()
signal pause_toggled()

@onready var level_music = preload("res://scenes/levels/LevelMusic.tscn")
@onready var scene_transition = preload("res://scenes/screens/SceneTransition.tscn")
@onready var death_screen = preload("res://scenes/screens/DeathScreen.tscn")
var level_music_instance : AudioStreamPlayer
var current_level : int
const SCENES : Array[PackedScene] = [
	preload("res://scenes/screens/MainMenu.tscn"),
	preload("res://scenes/levels/Level1.tscn"),
	preload("res://scenes/levels/Level2.tscn"),
	preload("res://scenes/levels/Level3.tscn"),
	preload("res://scenes/screens/VictoryScreen.tscn")
]

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _physics_process(_delta):
	if (Input.is_action_just_pressed("pause")):
		pause_toggled.emit()
		## DEBUG ##
	if Input.is_action_just_pressed("next_level"):
		next_level()

# changes the scene based on the name given
func change_scene(scene_number: int):
	var tree = get_tree()
	var transition_instance = scene_transition.instantiate()
	tree.root.add_child(transition_instance)
	await transition_instance.get_node("AnimationPlayer").animation_finished
	tree.change_scene_to_packed(SCENES[scene_number])
	transition_instance.queue_free()

# fades out the in-level music and loads the main menu
func return_to_main_menu():
	print(is_instance_valid(level_music_instance))
	if is_instance_valid(level_music_instance):
		var animator = level_music_instance.get_node("AnimationPlayer")
		animator.play("music_fade_out")
		change_scene(0)
		await animator.animation_finished
		level_music_instance.queue_free()
	else:
		change_scene(0)
	# makes sure the game is unpaused
	get_tree().paused = false

# load the first level and starts the in-level music (if not already playing)
func start_the_game():
	reset_input_keys.emit()
	current_level = 1
	await change_scene(current_level)
	if not level_music_instance:
		level_music_instance = level_music.instantiate()
		get_tree().root.add_child(level_music_instance)

# advances to the next screen
func next_level():
	current_level += 1
	if current_level == 4:
		go_to_victory_screen()
	else:
		await change_scene(current_level)

func go_to_victory_screen():
	var animator = level_music_instance.get_node("AnimationPlayer")
	animator.play("music_fade_out")
	change_scene(4)
	await animator.animation_finished
	level_music_instance.queue_free()

# quits the game
func quit_game():
	var tree = get_tree()
	var transition_instance = scene_transition.instantiate()
	tree.root.add_child(transition_instance)
	await transition_instance.get_node("AnimationPlayer").animation_finished
	get_tree().quit()

func set_sound(state: bool):
	AudioServer.set_bus_mute(0, state)
