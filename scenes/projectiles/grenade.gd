extends RigidBody2D

const speed = 750
var exploded: bool = false
var explosion_radius: int = 400

func explode():
	exploded = true
	$AnimationPlayer.play("Explosion")

func _process(_delta):
	if exploded:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			if 'hit' in target and in_range:
				target.hit()
