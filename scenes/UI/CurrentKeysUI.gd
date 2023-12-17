extends Control

@onready var animation_tree : AnimationTree = $AnimationTree
var keys : Dictionary = {
	"up" : {"current_key" : "", "label" : null},
	"down" : {"current_key" : "", "label" : null},
	"left" : {"current_key" : "", "label" : null},
	"right" : {"current_key" : "", "label" : null}
}

func _ready():
	GameManager.input_key_updated.connect(update_input_key)
	keys["up"]["label"] = $Up/Key
	keys["down"]["label"] = $Down/Key
	keys["left"]["label"] = $Left/Key
	keys["right"]["label"] = $Right/Key
	for action in keys:
		update_input_key(action, false)

# updates the content of a label to the new keybind
func update_input_key(action: String, play_animation: bool = true):
	var key = InputMap.action_get_events(action)[0]
	# if keycode is 0 (meaning unset), simply assign an empty string
	keys[action]["current_key"] = key.as_text_keycode() if key.keycode else "" 
	if play_animation:
		animation_tree.set("parameters/{0}/request".format([action]), 1)
	else:
		update_label_text(action)

# updates the specified label's text with the current key value
# this function is called by the AnimationPlayer
func update_label_text(action: String):
	keys[action]["label"].set_text(keys[action]["current_key"])
		
