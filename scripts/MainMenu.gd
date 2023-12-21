extends CanvasLayer

@onready var menu_animator : AnimationPlayer = $MenuAnimator
@onready var parallax_bg : ParallaxBackground = $ParallaxBackground
@onready var how_to_play_screen : Control = $HowToPlayScreen
@onready var music : AudioStreamPlayer = $Music

func _ready():
	how_to_play_screen.visible = false

func _physics_process(delta):
	parallax_bg.scroll_offset.x += 10 * delta

## main menu buttons ##
# load the how-to-play screen
func _on_play_pressed():
	await wait_for_animation("fade_out")
	how_to_play_screen.visible = true

# opens the settings sub-menu
func _on_settings_pressed():
	#await wait_for_animation("fade_out")
	print("Sound Menu")

# quits the game
func _on_quit_pressed():
	await wait_for_animation("fade_out")
	GameManager.quit_game()
	
# starts an animation and waits until it is over
func wait_for_animation(animation_name):
	menu_animator.play(animation_name)
	await menu_animator.animation_finished
	
## sub-menus buttons ##
# returns to the main menu
func _on_back_pressed():
	how_to_play_screen.visible = false
	await wait_for_animation("fade_in")

# starts the first level
func _on_start_pressed():
	menu_animator.play("music_fade_out")
	GameManager.start_the_game()
