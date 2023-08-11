extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Input
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	position += direction * 500 * delta
