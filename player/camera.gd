class_name PlayerCamera
extends Camera3D

var str: float
var freq: float
var dur: float = 1.0
var elapsed: float = 1.0

@export var noise: FastNoiseLite


func _ready():
	Global.camera = self

func _process(delta):
	elapsed += delta
	elapsed = min(elapsed, dur)
	h_offset = (noise.get_noise_2d(elapsed*freq, 0.0)-0.5)*str*(1.0-elapsed/dur)
	v_offset = (noise.get_noise_2d(0.0, elapsed*freq)-0.5)*str*(1.0-elapsed/dur)


func shake_screen(str: float, freq: float, dur: float):
	if str >= self.str*(1.0-self.elapsed/self.dur):
		self.str = str/20.0
		self.freq = freq*500.0
		self.dur = dur
		self.elapsed = 0.0
