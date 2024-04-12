extends Area3D


func _ready():
	body_entered.connect(player_fell)


func player_fell(player):
	Transition.transition_to("res://levels/level3_hodnik/level3_hodnik2.tscn", 0.02, Color.WHITE, Color.WHITE, 0.01)
	Global.play_sound(preload("res://sounds/human-impact-on-ground-6982.mp3"))
