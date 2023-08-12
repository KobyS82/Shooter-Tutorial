extends CharacterBody2D

signal laser_shot
signal grenade_shot


var can_laser: bool = true
var can_grenade: bool = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#Input
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * 500
	move_and_slide()
	
	# Primary action - Laser
	if Input.is_action_pressed("Primary Action") and can_laser:
		laser_shot.emit()
		can_laser = false
		$Timer.start()
	
	# Secondary action - Grenade
	if Input.is_action_pressed("Secondary Action") and can_grenade:
		grenade_shot.emit()
		can_grenade = false
		$GrenadeReloadTimer.start()


func _on_timer_timeout():
	can_laser = true


func _on_grenade_reload_timer_timeout():
	can_grenade = true
