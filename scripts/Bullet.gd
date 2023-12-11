extends Area2D

@export var speed : float
@export var damage : int

func _physics_process(delta):
	# moves the bullet in a straight line
	move_local_x(speed * delta)

func _on_body_entered(body):
	if (body.is_in_group("enemies")):
		body.hit(damage)
	queue_free()
