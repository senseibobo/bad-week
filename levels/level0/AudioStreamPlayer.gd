extends AudioStreamPlayer

var walk_sound = preload("res://sounds/going-on-a-forest-road-gravel-and-grass-6404.mp3")
var nature_sound = preload("res://sounds/evening-birds-singing-in-spring-background-sounds-of-nature-146388.mp3")
var attack_sound = preload("res://sounds/metal-knock-2-103060.mp3")

func play_walk_sound():
	self.stream = walk_sound
	play()

func play_attack_sound():
	self.stream = attack_sound
	play()

