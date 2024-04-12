extends AudioStreamPlayer3D


func _process(delta):
	position = position.rotated(Vector3.UP, delta)
