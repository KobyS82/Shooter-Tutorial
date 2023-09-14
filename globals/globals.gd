extends Node

signal stat_change

var laser_amount = 20:
	set(value):
		laser_amount = value
		stat_change.emit()

var grenade_amount = 5:
	set(value):
		grenade_amount = value
		stat_change.emit()

var player_damageable: bool = true
var health = 60:
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			if player_damageable:
				health = value
				player_damageable = false
				player_damageable_timer()
		stat_change.emit()

func player_damageable_timer():
	await get_tree().create_timer(0.5).timeout
	player_damageable = true

var player_pos: Vector2
