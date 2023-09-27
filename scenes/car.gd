extends PathFollow2D

var player_near: bool = false

@onready var line1: Line2D = $Turret/RayCast2D/Line2D
@onready var line2: Line2D = $Turret/RayCast2D2/Line2D

func fire():
	Globals.health -= 20

func _ready():
	#Creates 2nd point of laser
	line2.add_point($Turret/RayCast2D2.target_position)
	$FireSprites.hide()

func _process(delta):
	progress_ratio += 0.02 * delta
	if player_near:
		$Turret.look_at(Globals.player_pos)
		$FireSprites.look_at(Globals.player_pos)
	$Turret/RayCast2D.get_collider()


func _on_notice_area_body_entered(_body):
	player_near = true
	$AnimationPlayer.play("laser_load")

func _on_notice_area_body_exited(_body):
	player_near = false
