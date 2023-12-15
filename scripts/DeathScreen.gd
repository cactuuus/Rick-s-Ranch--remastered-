extends CanvasLayer

# restarts from level 1
func _on_play_again_pressed():
	GameManager.change_scene("Level 1")

# returns to main menu
func _on_menu_pressed():
	GameManager.return_to_main_menu()
