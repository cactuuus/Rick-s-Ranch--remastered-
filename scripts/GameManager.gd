extends Node

signal shot_fired(spawn_position: Vector2, rotation: float, bullet_damage: int)
signal player_is_hit(damage: int, enemy_direction: Vector2)
signal player_is_dead()
signal input_key_updated(action_name: String)
signal reset_input_keys()

const SCENES : Dictionary = {
	"Main Menu" : "res://scenes/screens/MainMenu.tscn",
	"Level 1" : "res://scenes/levels/TestScene.tscn",
}

# changes the scene based on the name given
func change_scene(scene_name: String):
	get_tree().change_scene_to_file(SCENES[scene_name])

# loads the main menu
func return_to_main_menu():
	change_scene("Main Menu")

# loads the first lavel
func start_the_game():
	reset_input_keys.emit()
	change_scene("Level 1")
	
# quits the game
func quit_game():
	get_tree().quit()

