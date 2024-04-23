extends Area3D


func _ready():
	body_exited.connect(player_exited)
	body_entered.connect(test)
	body_exited.connect(test)


func test(player):
	print("test " + player.name)


func player_exited(player: Player):
	var p1 = Vector2(player.global_position.x, player.global_position.z)
	var angle = p1.angle_to_point(Vector2())
	if (angle > -3*PI/4.0 and angle < -PI/4.0) \
			or (angle > PI/4 and angle < 3*PI/4.0):
		var s = sign(player.global_position.z)
		player.global_position.z -= s*59.0
		get_tree().call_group("MomTPMove", "translate", Vector3(0,0,-s*59))
		get_tree().call_group("MomTPMoveAlt", "alt_translate", Vector3(0,0,-s*59))
	else:
		var s = sign(player.global_position.x)
		player.global_position.x -= s*59.0
		get_tree().call_group("MomTPMove", "translate", Vector3(-s*59,0,0))
		get_tree().call_group("MomTPMoveAlt", "alt_translate", Vector3(-s*59,0,0))

