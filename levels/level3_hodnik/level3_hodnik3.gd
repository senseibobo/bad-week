extends Node3D


@onready var environment = $WorldEnvironment.environment


func _on_tp_4_teleported():
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
	tween.tween_interval(6.0)
	tween.tween_property(environment, "volumetric_fog_density", 80.0, 40.0)
	tween.tween_callback(done)


func done():
	Transition.transition_to("res://levels/level3_hodnik/level3_hodnik4.tscn", 1.5, Color.BLACK, Color.BLACK)
