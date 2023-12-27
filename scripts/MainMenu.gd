extends CanvasLayer

@onready var menu_animator : AnimationPlayer = $MenuAnimator
@onready var parallax_bg : ParallaxBackground = $ParallaxBackground
@onready var how_to_play_screen : Control = $HowToPlayScreen
@onready var music : AudioStreamPlayer = $Music
@onready var sound_btn : = $MainMenu/MenuOptions/Sound
@onready var sound_striketrough : = $MainMenu/MenuOptions/Sound/Striketrough

func _ready():
	how_to_play_screen.visible = false
	var muted = AudioServer.is_bus_mute(0)
	sound_btn.set_pressed_no_signal(muted)
	sound_striketrough.visible = muted

func _physics_process(delta):
	parallax_bg.scroll_offset.x += 10 * delta

## main menu buttons ##
# load the how-to-play screen
func _on_play_pressed():
	await wait_for_animation("fade_out")
	how_to_play_screen.visible = true

# quits the game
func _on_quit_pressed():
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

func _on_sound_toggled(toggled_on):
	GameManager.set_sound(toggled_on)
	sound_striketrough.visible = not sound_striketrough.visible
