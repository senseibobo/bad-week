extends Area3D


signal teleported


@export var teleport_x: float = 0.0
@export var teleport_z: float = 0.0
@export var on_exit: bool = false


func _ready():
	if on_exit:
		body_exited.connect(player_entered)
	else:
		body_entered.connect(player_entered)


func player_entered(player):
	teleported.emit()
	player.global_position.x += teleport_x
	player.global_position.z += teleport_z
