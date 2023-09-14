extends CharacterBody2D

var player_nearby: bool = false
var can_laser: bool = true
var right_gun: bool = true

signal laser(pos, direction)

func hit():
	queue_free()

func _process(_delta):
	
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			var markers = $LaserSpawnPositions.get_child(right_gun)
			var pos: Vector2 = markers.global_position
			right_gun = not right_gun
			var direction: Vector2 = (Globals.player_pos - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$LaserCooldown.start()

func _on_attack_area_body_entered(_body):
	player_nearby = true


func _on_attack_area_body_exited(_body):
	player_nearby = false


func _on_laser_cooldown_timeout():
	can_laser = true
