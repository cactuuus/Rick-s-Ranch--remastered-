extends Node

var available_keys : Array[Key]
var controls : Array[String] = ["up", "down", "left", "right"]

func _ready():
	available_keys = [
	KEY_Q, KEY_E, KEY_R, KEY_T, KEY_Y, KEY_U, KEY_I, KEY_O, KEY_P, KEY_F, KEY_G,
	KEY_H, KEY_J, KEY_K, KEY_L, KEY_Z, KEY_X, KEY_C, KEY_V, KEY_B, KEY_N, KEY_M 
	]
	var starting_keys : Array[Key] = [KEY_W, KEY_S, KEY_A, KEY_D]	
	for i in range(4):
		var keybind = InputEventKey.new()
		keybind.set_keycode(starting_keys[i])
		InputMap.action_add_event(controls[i], keybind)
		
