extends Node

var player: Player
var old_scene: String

func _input(event):
	if Input.is_action_just_pressed("fullscreen"):
		if get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN:
			get_window().mode = Window.MODE_WINDOWED
		else:
			get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
	elif Input.is_action_just_pressed("kill_game"):
		get_tree().quit()


func play_sound(stream: AudioStream, position: Vector3 = Vector3.ZERO):
	var stream_player = AudioStreamPlayer.new()
	stream_player.stream = stream
	add_child(stream_player)
	stream_player.play()
	stream_player.finished.connect(stream_player.queue_free)
