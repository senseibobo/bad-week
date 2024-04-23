extends Node3D


enum State {
	IDLE,
	ATTACK1,
	ATTACK2
}


@export var started: bool = false
@export var max_hp: float = 300.0
@export var fetus_scene: PackedScene

var state: int = State.IDLE
var timer: float = 0.0
var time: float = 0.0

@onready var player: Player = Global.player
@onready var eyes: Node3D = $Visuals/Eyes
@onready var target_spot: Node3D = $Visuals/Body
@onready var fetus_launcher: Marker3D = $Visuals/FetusLauncherPosition
@onready var fetus_cast: RayCast3D = $FetusCast
@onready var hp: float = max_hp
var eye_positions: Array



func _ready():
	_init_eye_positions()


func _commence_start():
	Tools.timer(2.0, self).connect(start)


func _init_eye_positions():
	for eye in $Visuals/Eyes.get_children():
		if eye.get_child_count() > 0:
			eye_positions.append(eye.get_child(0))


func start():
	var tween = create_tween()
	tween.tween_property($UuuuuuuSound,"volume_db",0.0, 2.0).from(-80.0)
	$UuuuuuuSound.play()
	started = true
	_change_state(State.ATTACK2)


func _process(delta):
	_process_body_rotation(delta)
	_process_eyes()
	_process_state(delta)


func _process_body_rotation(delta):
	var angle = -Vector2(global_position.x, global_position.z).angle_to_point(
		Vector2(player.global_position.x, player.global_position.z)) + PI/2
	rotation.y = lerp_angle(rotation.y, angle, 2.0*delta)


func _process_eyes():
	eyes.look_at(Global.player.global_position)
	eyes.rotate(eyes.basis.y.normalized(), PI)


func _process_state(delta):
	match state:
		State.ATTACK1:
			pass


func _change_state(new_state):
	state = new_state
	match state:
		State.ATTACK1:
			_start_attack1()
		State.ATTACK2:
			_start_attack2()


func _start_attack1():
	var count = 0
	while state == State.ATTACK1:
		count += 1
		_launch_eye()
		if count >= 3:
			_change_state(State.ATTACK2)
		await Tools.timer(2.0, self)

func _start_attack2(): # lauch exploding fetuses
	for i in 2:
		fetus_cast.global_position.x = Global.player.global_position.x
		fetus_cast.global_position.z = Global.player.global_position.z
		fetus_cast.force_raycast_update()
		if fetus_cast.is_colliding():
			var pos = fetus_cast.get_collision_point()
			var fetus = fetus_scene.instantiate()
			fetus.arrival_time = 2.0
			get_parent().add_child(fetus)
			fetus.global_position = fetus_launcher.global_position
			fetus.start_position = fetus.global_position
			fetus.target_position = pos
		await Tools.timer(2.5, self)
	_change_state(State.ATTACK1)
		


func _launch_eye():
	var eye = preload("res://enemies/mom/eye.tscn").instantiate()
	eye.mom = self
	eye.target = player
	get_tree().current_scene.add_child(eye)
	eye.global_position = eye_positions.pick_random().global_position


func hit(damage: float):
	hp -= damage
	if hp <= 0:
		death()


func death():
	Transition.transition_to("res://levels/level3_hodnik/mrtvi.tscn", 2.0, Color.BLACK, Color.BLACK, 1.0)
	for enemy in Global.enemies:
		enemy.queue_free()
	state = State.IDLE
