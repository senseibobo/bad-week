extends Area3D


@export var teleport_x: float = 0.0
@export var teleport_z: float = 0.0


func _ready():
	body_entered.connect(player_entered)


func player_entered(player):
	player.global_position.x += teleport_x
	player.global_position.z += teleport_z
