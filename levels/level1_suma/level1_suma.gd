extends Node3D


func _on_exit_door_entered():
	Transition.transition_to("res://levels/level2_bolnica/room.tscn", 0.5, Color.WHITE, Color.WHITE, 3.0)
