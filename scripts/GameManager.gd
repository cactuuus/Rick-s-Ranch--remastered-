extends Node

signal shot_fired(spawn_position: Vector2, rotation: float, bullet_damage: int)
signal player_is_hit(damage: int, enemy_direction: Vector2)

const SCENES : Dictionary = {
	"Main Menu" : "res://scenes/MainMenu.tscn",
	"Test Level" : "res://scenes/TestScene.tscn"
}

# changes the scene based on the name given
func change_scene(scene_name: String):
	get_tree().change_scene_to_file(SCENES[scene_name])
	
# quits the game
func quit_game():
	get_tree().quit()
	
func player_is_dead():
	await get_tree().create_timer(2).timeout
	change_scene("Main Menu")
	
