extends Interactable


func on_interact(player):
	super(player)
	player.has_shovel = true
	queue_free()
