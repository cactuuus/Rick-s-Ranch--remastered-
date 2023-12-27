extends Control

@onready var enemies_left_label : Label = $Sign/EnemiesLeft
@onready var animator : AnimationPlayer = $AnimationPlayer

@export var snake: bool
@export var vulture: bool
@export var bison: bool
@onready var enemies_encouterable: Dictionary = {
	$Sign/Enemies/Snake: snake,
	$Sign/Enemies/Vulture: vulture,
	$Sign/Enemies/Bison: bison
}

func _ready():
	# blacks out the enemies not available in the current level
	for enemy_icon in enemies_encouterable:
		if not enemies_encouterable[enemy_icon]:
			enemy_icon.set_self_modulate(Color.BLACK)

# updates the number in the enemies left label
func update_enemies_left_label(enemies_left: int, animate: bool = true):
	enemies_left_label.set_text("%d" % [enemies_left])
	if animate:
		animator.play("font_pulse")
