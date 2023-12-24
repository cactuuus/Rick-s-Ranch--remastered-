extends Node

var available_keys : Array[Key]
var actions : Array[String] = ["up", "down", "left", "right"]

var timer : float = 0

func _ready():
	set_available_keys()
	set_initial_controls()

# maps directional controls to WASD
func set_initial_controls():
	var starting_keys : Array[Key] = [KEY_W, KEY_S, KEY_A, KEY_D]
	for i in range(4):
		var keybind : InputEventKey = InputEventKey.new()
		keybind.set_keycode(starting_keys[i])
		InputMap.action_add_event(actions[i], keybind)

# sets available keys to a list of all letters other than WASD
func set_available_keys():
	available_keys = [
	KEY_Q, KEY_E, KEY_R, KEY_T, KEY_Y, KEY_U, KEY_I, KEY_O, KEY_P, KEY_F, KEY_G,
	KEY_H, KEY_J, KEY_K, KEY_L, KEY_Z, KEY_X, KEY_C, KEY_V, KEY_B, KEY_N, KEY_M 
	]
	
