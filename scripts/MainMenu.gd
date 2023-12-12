extends Node2D

@onready var menu_animator : AnimationPlayer = $MenuAnimator
@onready var parallax_bg : ParallaxBackground = $ParallaxBackground

func _on_start_button_up():
	await wait_fade_out_animation()
	GameManager.change_scene("Test Level")

func _on_sound_button_up():
	await wait_fade_out_animation()
	print("Sound Menu")

func _on_quit_button_up():
	await wait_fade_out_animation()
	GameManager.quit_game()

func wait_fade_out_animation():
	menu_animator.play("fade_out")
	await menu_animator.animation_finished
	
