extends Node3D


func _ready():
	await $AnimationPlayer.animation_finished
	Transition.transition_to("res://levels/level3_hodnik/end.tscn")
