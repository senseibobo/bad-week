extends Interactable


@onready var marker: Marker3D = $Marker3D


func on_interact(player):
	super(player)
	player.global_position = marker.global_position
