extends Interactable


func on_interact(player):
	player.lamps += 1
	queue_free()
