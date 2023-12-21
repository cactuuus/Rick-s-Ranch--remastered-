extends Node

signal shot_fired(spawn_position: Vector2, rotation: float, bullet_damage: int)
signal player_is_hit(damage: int, enemy_direction: Vector2)
signal player_is_dead()
signal enemy_killed()
signal input_key_updated(action_name: String)
signal reset_input_keys()

@onready var level_music = preload("res://scenes/levels/LevelMusic.tscn")
@onready var scene_transition = preload("res://scenes/screens/SceneTransition.tscn")
@onready var death_screen = preload("res://scenes/screens/DeathScreen.tscn")
var level_music_instance
const SCENES : Dictionary = {
	"Main Menu" : "res://scenes/screens/MainMenu.tscn",
	"Level 1" : "res://scenes/levels/TestScene.tscn",
}

# changes the scene based on the name given
func change_scene(scene_name: String):
	var tree = get_tree()
	var transition_instance = scene_transition.instantiate()
	tree.root.add_child(transition_instance)
	await transition_instance.get_node("AnimationPlayer").animation_finished
	tree.change_scene_to_file(SCENES[scene_name])
	transition_instance.queue_free()

# fades out the in-level music and loads the main menu
func return_to_main_menu():
	var animator = level_music_instance.get_node("AnimationPlayer")
	animator.play("music_fade_out")
	change_scene("Main Menu")
	await animator.animation_finished
	level_music_instance.queue_free()

# load the first level and starts the in-level music (if not already playing)
func start_the_game():
	reset_input_keys.emit()
	await change_scene("Level 1")
	if not level_music_instance:
		level_music_instance = level_music.instantiate()
		get_tree().root.add_child(level_music_instance)
	

# quits the game
func quit_game():
	get_tree().quit()

