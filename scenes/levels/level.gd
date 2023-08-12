extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _on_area_2d_body_entered(_body):
	print("entered")


func _on_area_2d_body_exited(_body):
	print("exited")


func _on_player_laser_shot(pos):
	var laser = laser_scene.instantiate()
	laser.position = pos
	$Projectiles.add_child(laser)
	print("laser shot")


func _on_player_grenade_shot(pos):
	var grenade = grenade_scene.instantiate()
	grenade.position = pos
	$Projectiles.add_child(grenade)
	print("grenade shot")
