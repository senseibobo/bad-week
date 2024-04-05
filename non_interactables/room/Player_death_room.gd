extends Node3D

@export var sensitivity: float = 0.6
@onready var camera = $Camera3D


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		camera.rotate_x(-sensitivity*event.relative.y/100.0)
		rotate_y(-sensitivity*event.relative.x/100.0)
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, 20, 100)
		rotation_degrees.y = clamp(rotation_degrees.y, -120, -60)

func _process(delta):
	_process_interacting()

func _process_interacting():
	if Input.is_action_just_pressed("interact"):
		Transition.transition_to(Global.old_scene)
