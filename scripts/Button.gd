extends TextureButton

@export var text : String = ""
const modulate_color = Color(1, 1, 1, 1)

func _ready():
	$Label.set_text(text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_pressed():
		set_self_modulate(modulate_color.darkened(0.5))
	else:
		set_self_modulate(modulate_color)
