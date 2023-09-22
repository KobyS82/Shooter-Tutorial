extends CharacterBody2D

var active: bool = false
var speed: float = 200.0

var vulnerable: bool = true
var health: int = 50
var player_close: bool = false

func _ready():
	$Explosion.hide()
	$Sprite2D.show()

func _physics_process(delta):
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed
		speed += 1.0
		#stops on collision
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("explosion")

func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$Sprite2D.material.set_shader_parameter("progress", 1)
		$Node/DamageTimer.start()
	if health <= 0:
		$AnimationPlayer.play("explosion")


func _on_notice_area_body_entered(_body):
	active = true


func _on_damage_timer_timeout():
	vulnerable = true
	$Sprite2D.material.set_shader_parameter("progress", 0)


func _on_explosion_area_2d_body_entered(_body):
	player_close = true

func _on_explosion_area_2d_body_exited(_body):
	player_close = false

func _on_animation_player_animation_started(explosion):
	if player_close:
		Globals.health -= 10
