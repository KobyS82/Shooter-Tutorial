extends CharacterBody2D

signal laser_shot(pos)
signal grenade_shot(pos)


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
		#randomly select marker for the laser start position
		var laser_markers = $LaserStartPosition.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		$Timer.start()
		#emit pos we selected
		laser_shot.emit(selected_laser.global_position)
	
	# Secondary action - Grenade
	if Input.is_action_pressed("Secondary Action") and can_grenade:
		var pos = $LaserStartPosition/Start.global_position
		can_grenade = false
		$GrenadeReloadTimer.start()
		grenade_shot.emit(pos)


func _on_timer_timeout():
	can_laser = true


func _on_grenade_reload_timer_timeout():
	can_grenade = true
