extends Node2D

@onready var health_bar : ProgressBar = $HealthBar
var max_health : int
var current_health : int

# called on character _ready(), it sets this module using the character's stats 
func setup(char_max_health: int):
	max_health = char_max_health
	current_health = char_max_health
	health_bar.max_value = char_max_health
	update_health_bar()

# decreases health based on the damage received
func take_damage(damage: int):
	current_health -= damage
	update_health_bar()

# returns true if player is dead
func is_dead() -> bool:
	return current_health <= 0
	
# updates the health bar
func update_health_bar():
	health_bar.value = current_health
