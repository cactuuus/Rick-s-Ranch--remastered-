extends Node

@export var text = ""

func _ready():
	$Label.set_text(text)
