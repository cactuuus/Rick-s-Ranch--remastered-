extends Area2D

@export var bullet_speed : float = 500

func _physics_process(delta):
	move_local_x(bullet_speed * delta) 
	
