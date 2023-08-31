extends ItemContainer

func hit():
	$LidSprite.hide()
	if not opened:
		for i in range(5):
			var pos = $SpawnPositions.get_child(randi()%$SpawnPositions.get_child_count()).global_position
			open.emit(pos, current_direction)
		opened = true
