extends ItemContainer

func hit():
	$LidSprite.hide()
	if not opened:
		var pos = $SpawnPositions/Marker2D.global_position
		open.emit(pos, current_direction)
		opened = true
