extends CharacterBody2D

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
		print("shot laser")
		can_laser = false
		$Timer.start()
	
	# Secondary action - Grenade
	if Input.is_action_pressed("Secondary Action") and can_grenade:
		print("grenade shot")
		can_grenade = false
		$GrenadeReloadTimer.start()


func _on_timer_timeout():
	can_laser = true


func _on_grenade_reload_timer_timeout():
	can_grenade = true
