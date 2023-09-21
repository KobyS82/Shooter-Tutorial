extends CharacterBody2D

var active: bool = false
var player_near: bool = false
var can_attack: bool = true
var damageable: bool = true

var health: int = 20

@onready var speed: int = 200

func hit():
	if damageable:
		health -= 10
		damageable = false
		$Timers/DamageTimer.start()
		$AnimatedSprite2D.material.set_shader_parameter("progress", 1)
		$Particles/DamageParticles.emitting = true
	if health <= 0:
		await get_tree().create_timer(0.5).timeout
		queue_free()


func _process(_delta):
	var direction: Vector2 = (Globals.player_pos - position).normalized()
	velocity = direction * speed
	if active:
		look_at(Globals.player_pos)
		move_and_slide()


func _on_notice_area_2d_body_entered(body):
	print(body)
	active = true
	$AnimatedSprite2D.play("walk")

func _on_notice_area_2d_body_exited(_body):
	active = false
	$AnimatedSprite2D.stop()

func _on_attack_area_2d_body_entered(_body):
	player_near = true
	$AnimatedSprite2D.play("attack")

func _on_attack_area_2d_body_exited(_body):
	player_near = false

func _on_damage_timer_timeout():
	damageable = true
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)

func _on_attack_timer_timeout():
	$AnimatedSprite2D.play("attack")

func _on_animated_sprite_2d_animation_finished():
	if player_near:
		Globals.health -= 10
		$Timers/AttackTimer.start()
