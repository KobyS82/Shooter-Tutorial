extends CharacterBody2D

var player_nearby: bool = false
var player_close: bool = false
var can_attack: bool = true
var damageable: bool = true

var health: int = 100

@onready var speed: int = 200

func hit():
	if damageable:
		health -= 10
		damageable = false
		$Timers/DamageTimer.start()
		$AnimatedSprite2D.material.set_shader_parameter("progress", 1)
	if health <= 0:
		queue_free()

func _process(_delta):
	if player_nearby and can_attack:
		look_at(Globals.player_pos)
		var direction: Vector2 = (Globals.player_pos - position).normalized()
		velocity = direction * speed
		move_and_slide()
		if player_close:
			can_attack = false
			velocity = Vector2.ZERO
			$AnimatedSprite2D.play("attack")
			$Timers/AttackTimer.start()


func _on_notice_area_2d_body_entered(body):
	player_nearby = true
	$AnimatedSprite2D.play("walk")

func _on_notice_area_2d_body_exited(body):
	player_nearby = false
	$AnimatedSprite2D.stop()

func _on_attack_area_2d_body_entered(body):
	player_close = true

func _on_attack_area_2d_body_exited(body):
	player_close = false

func _on_damage_timer_timeout():
	damageable = true
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)

func _on_attack_timer_timeout():
	can_attack = true
