extends Control


func _on_start_pressed():
	Transition.transition_to("res://levels/level0/room.tscn", 2.0)


func _on_quit_pressed():
	get_tree().quit()
