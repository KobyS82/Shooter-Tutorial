extends CharacterBody2D


func _physics_process(_delta):
	var direction = Vector2.RIGHT
	velocity = direction * 200
	move_and_slide()

func hit():
	print("damaged")