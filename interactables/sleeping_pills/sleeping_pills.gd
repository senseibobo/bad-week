extends Node3D

@onready var pills = $Interactible
@export var delete: bool = false

func _ready():
	if delete: queue_free()
	pills.interacted.connect(on_pills_interacted)
	
func on_pills_interacted():
	if(Global.player.has_letter):
		Global.player.take_pills()
		self.queue_free()
