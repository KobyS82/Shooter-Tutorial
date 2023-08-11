extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#Input
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * 500
	move_and_slide()
	
	# Primary action - Laser
	if Input.is_action_pressed("Primary Action"):
		pass
	
	# Secondary action - Grenade
	if Input.is_action_pressed("Secondary Action"):
		pass
