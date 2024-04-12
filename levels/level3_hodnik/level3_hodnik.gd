extends Node3D



func _start_whispers():
	print("A")
	var whispers = Global.player.get_node("WhispersSound")
	whispers.play()
	var tween = create_tween()
	tween.tween_property($Uuuuuu, "volume_db", $Uuuuuu.volume_db, 2.0).from(-50.0)
	$Uuuuuu.play()
