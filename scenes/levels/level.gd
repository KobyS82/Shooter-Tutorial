extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(_body):
	print("entered")


func _on_area_2d_body_exited(_body):
	print("exited")


func _on_player_laser_shot():
	print("laser shot")


func _on_player_grenade_shot():
	print("grenade shot")
