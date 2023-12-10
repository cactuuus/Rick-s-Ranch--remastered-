extends Area2D

@export var bullet_speed : float = 400

func _physics_process(delta):
	# moves the bullet in a straight line
	move_local_x(bullet_speed * delta) 

# To do:
# on collision:
# if enemy -> enemy.take_damage()
# destroy bullet
