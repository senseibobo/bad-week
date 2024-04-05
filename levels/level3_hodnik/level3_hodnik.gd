extends Node3D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


var deaths: int = 0

func _on_mom_died():
	add_death()


func _on_kid_died():
	add_death()

func add_death():
	deaths +=1 
	if deaths >= 2:
		await get_tree().create_timer(2.0).timeout
		Transition.transition_to("res://levels/level3_hodnik/mrtvi.tscn")


func _on_vrata_interacted():
	Global.player.global_position = $tpMarker.global_position
