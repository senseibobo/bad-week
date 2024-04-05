extends Node3D

@onready var key = $Interactable

func _ready():
	key.interacted.connect(on_key_interacted)
	
func on_key_interacted():
	Global.player.pick_up_key()
	self.queue_free()
