extends CharacterBody2D

signal laser_shot(pos, direction)
signal grenade_shot(pos, direction)

var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 500
var speed: int = max_speed

func hit():
	Globals.health -= 10

func _process(_delta):
	#Input
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_pos = global_position
	
	# Rotate 
	look_at(get_global_mouse_position())
	
	# Primary action - Laser
	var player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_pressed("Primary Action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
		#randomly select marker for the laser start position
		var laser_markers = $LaserStartPosition.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		$Timer.start()
		#emit pos we selected
		laser_shot.emit(selected_laser.global_position, player_direction)
	
	# Secondary action - Grenade
	if Input.is_action_pressed("Secondary Action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		can_grenade = false
		$GrenadeReloadTimer.start()
		var pos = $LaserStartPosition/Start.global_position
		grenade_shot.emit(pos, player_direction)

func _on_timer_timeout():
	can_laser = true

func _on_grenade_reload_timer_timeout():
	can_grenade = true

