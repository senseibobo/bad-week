extends AudioStreamPlayer

var walk_sound = preload("res://sounds/hallway_walk.mp3")
#var nature_sound = preload("res://sounds/evening-birds-singing-in-spring-background-sounds-of-nature-146388.mp3")

func play_walk_sound():
	self.stream = walk_sound
	play()
