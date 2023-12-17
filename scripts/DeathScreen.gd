extends Control

# restarts from level 1
func _on_play_again_pressed():
	GameManager.start_the_game()

# returns to main menu
func _on_menu_pressed():
	GameManager.return_to_main_menu()
