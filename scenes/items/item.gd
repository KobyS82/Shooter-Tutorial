extends Area2D

var rotation_speed: int = 3
var type_options = ['laser', 'laser', 'laser', 'laser', 'grenade', 'health']
var type = type_options[randi()%len(type_options)]

func _ready():
	
	if type == 'laser':
		$Sprite2D.modulate = Color(0.1, 0.1, 0.4)
	if type == 'grenade':
		$Sprite2D.modulate = Color(0.8, 0.1, 0.1)
	if type == 'health':
		$Sprite2D.modulate = Color(0.1, 0.8, 0.1)

func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(body):
	body.add_item(type)
	queue_free()
