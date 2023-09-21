extends CharacterBody2D

var active: bool = false
var speed: int = 300

var vulnerable: bool = true
var health: int = 50

func _ready():
	$Explosion.hide()
	#Don't need this
#	$Sprite2D.show()

func _physics_process(_delta):
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed
		move_and_slide()

func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$Sprite2D.material.set_shader_parameter("progress", 1)
		$DamageTimer.start()
	if health <= 0:
		$AnimationPlayer.play("explosion")


func _on_notice_area_body_entered(_body):
	active = true


func _on_damage_timer_timeout():
	vulnerable = true
