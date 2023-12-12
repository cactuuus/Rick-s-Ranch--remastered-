extends Node2D

@onready var menu_animator : AnimationPlayer = $MenuAnimator
@onready var parallax_bg : ParallaxBackground = $ParallaxBackground
@onready var info_screen : PackedScene = preload("res://scenes/Menu/InfoScreen.tscn")

func _ready():
	GameManager.back_btn_pressed.connect(back_to_main_menu)

func _on_sound_button_up():
	await wait_fade_out_animation()
	print("Sound Menu")

func _on_quit_button_up():
	await wait_fade_out_animation()
	GameManager.quit_game()

func wait_fade_out_animation():
	menu_animator.play("fade_out")
	await menu_animator.animation_finished
	
func _on_play_button_up():
	await wait_fade_out_animation()
	var info_screen_instance = info_screen.instantiate()
	add_child(info_screen_instance)

func back_to_main_menu():
	pass
