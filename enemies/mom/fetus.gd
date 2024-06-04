extends Node3D

@export var shockwave_scene: PackedScene

var start_position: Vector3
var target_position: Vector3
var current_time: float 
var arrival_time: float
var arrived: bool = false

@onready var trail: LineRenderer3D = $Trail
@onready var mesh: MeshInstance3D = $Fetus
@onready var particles: GPUParticles3D = $GPUParticles3D



func _ready():
	_trail_points()

func _physics_process(delta):
	if arrived: return
	current_time += delta
	var t = current_time/arrival_time;
	var t_xz = ease(t, 1.2)
	var t_y = ease(t, 3.0)
	global_position.x = lerp(start_position.x, target_position.x, t_xz)
	global_position.y = lerp(start_position.y, target_position.y, t_y)
	global_position.z = lerp(start_position.z, target_position.z, t_xz)
	
	if global_position != target_position:
		look_at(target_position)
	
	if current_time >= arrival_time:
		arrived = true
		explode()


func alt_translate(offset: Vector3):
	print("alt move")
	translate(offset)
	target_position += offset
	for i in trail.points.size():
		trail.points[i] += offset


func _trail_points():
	trail.points = []
	await get_tree().process_frame
	trail.top_level = true
	trail.global_position = Vector3()
	var points: Array[Vector3]
	for i in 7:
		points.append(global_position)
	while true:
		await Tools.timer(0.05, self)
		points.pop_front()
		points.append(global_position)
		trail.points = points
		

func explode():
	$FetusSound.stop()
	$FetusDeathSound.play()
	Global.camera.shake_screen(20.0, 10.0, 0.5)
	mesh.queue_free()
	particles.emitting = false
	var shockwave = shockwave_scene.instantiate()
	get_parent().add_child(shockwave)
	shockwave.global_position.x = target_position.x
	shockwave.global_position.z = target_position.z
	
	Tools.timer(3.0, self).connect(queue_free)
