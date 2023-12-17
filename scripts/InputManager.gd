extends Node

const TIME_LIMIT : float = 2
var available_keys : Array[Key]
# keeps track of how long an action had been used
var movement_tracker : Dictionary

func _ready():
	GameManager.reset_input_keys.connect(set_to_initial_state)

func _physics_process(delta):
	# keeps track of how long each action as been used
	for action_name in movement_tracker:
		if Input.is_action_pressed(action_name):
			movement_tracker[action_name] += delta
			if movement_tracker[action_name] > TIME_LIMIT:
				update_movement_action(action_name)
				GameManager.input_key_updated.emit(action_name)

# called every time before loading "level 1": it resets the input variables to their default state
func set_to_initial_state():
	InputMap.load_from_project_settings()
	available_keys = [
		KEY_Q, KEY_E, KEY_R, KEY_T, KEY_Y, KEY_U, KEY_I, KEY_O, KEY_P, KEY_F, KEY_G,
		KEY_H, KEY_J, KEY_K, KEY_L, KEY_Z, KEY_X, KEY_C, KEY_V, KEY_B, KEY_N, KEY_M 
	]
	available_keys.shuffle()
	movement_tracker = {
		"up" : 0,
		"down" : 0,
		"left" : 0,
		"right" : 0
	}

# handle the update of the movement action
func update_movement_action(action_name):
	# necessary to release the action, otherwise it carries on beign true as it does not
	# register the older event key ever being released
	Input.action_release(action_name)
	var key = get_random_key()
	remap_action_key(action_name, key)
	if not key:
		movement_tracker.erase(action_name)
	else:
		movement_tracker[action_name] = 0

# remap an action to the given key (removing all other keys bind to it), and resets its counter
func remap_action_key(action_name: String, keycode: Key):
	var input_key : InputEventKey = InputEventKey.new()
	input_key.set_keycode(keycode)
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, input_key)

# returns a random key from the available keys. if none, emits a signal
func get_random_key() -> Key:
	var key = available_keys.pop_front()
	if not key:
		key = KEY_NONE
		####### signal that no more keys are available
		print("no more keys available!")
	return key

