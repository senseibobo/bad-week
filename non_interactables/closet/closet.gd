extends StaticBody3D


signal left_door_open
signal right_door_open
signal left_door_closed
signal right_door_closed
signal both_open
signal both_closed


var left_open: bool = false
var right_open: bool = false

func toggle_left():
	left_open = not left_open
	if left_open:
		left_door_open.emit()
		if right_open:
			both_open.emit()
	else:
		left_door_closed.emit()
		if not right_open:
			both_closed.emit()

func toggle_right():
	right_open = not right_open
	if right_open:
		right_door_open.emit()
		if left_open:
			both_open.emit()
	else:
		right_door_closed.emit()
		if not left_open:
			both_closed.emit()
