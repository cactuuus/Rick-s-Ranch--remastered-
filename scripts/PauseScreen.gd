extends Control

func _on_resume_pressed():
	GameManager.pause_toggled.emit()

func _on_menu_pressed():
	GameManager.return_to_main_menu()
