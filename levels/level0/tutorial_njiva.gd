extends Node3D

func _on_exit_door_entered():
	Transition.transition_to("res://levels/level1_suma/room.tscn", 0.2, Color.WHITE, Color.WHITE, 3.0)


