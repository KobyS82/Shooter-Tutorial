extends CharacterBody2D

var player_nearby: bool = false
var can_laser: bool = true
var right_gun: bool = true
var damageable: bool = true

var health: int = 30

signal laser(pos, direction)

func hit():
	if damageable:
		health -= 10
		damageable = false
		$Timers/DamageTimer.start()
		$Sprite2D.material.set_shader_parameter("progress", 1)
	if health <= 0:
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
			$Timers/LaserTimer.start()

func _on_attack_area_body_entered(_body):
	player_nearby = true


func _on_attack_area_body_exited(_body):
	player_nearby = false


func _on_laser_timer_timeout():
	can_laser = true


func _on_damage_timer_timeout():
	$Sprite2D.material.set_shader_parameter("progress", 0)
	damageable = true


