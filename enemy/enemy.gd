class_name Enemy
extends CharacterBody3D


signal died
signal noticed_player
signal attacked_player
signal got_hit


const blood_splatter = preload("res://non_interactables/blood_splatter/blood_splatter.tscn")


enum State {
	IDLE,
	CHASE,
	ATTACK
}


@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var health: float = max_health
@onready var parent = get_parent()
@onready var vision_raycast: RayCast3D = $RayCast3D
@onready var audioplayer = $AudioStreamPlayer3D 

var follow_timer: float = 0.0
var attack_timer: float = 0.0
var state: int = State.IDLE

@export var speed: float = 4.0
@export var attack_range: float = 2.0
@export var attack_cooldown: float = 3.0
@export var follow_range: float = 10.0
@export var damage: float = 20.0
@export var max_health: float = 5.0
@export var sound: AudioStream
@export var death_sound: AudioStream
@export var blind: bool = false
@export var follow_time: float = 2.9



func _ready():
	set_physics_process(false)
	await get_tree().physics_frame
	set_physics_process(true)
	audioplayer.set_stream(sound)

func _physics_process(delta):
	if not is_instance_valid(Global.player):
		return
	if state != State.IDLE:
		print(attack_timer)
	attack_timer -= delta
	_process_state(delta)

func _process_state(delta):
	if state != State.IDLE:
		print(state)
	match state:
		State.IDLE:
			_look_for_player()
		State.CHASE:
			_process_movement(delta)
			if _is_in_attack_range():
				_start_attacking()
			elif not _sees_player():
				follow_timer -= delta
				if follow_timer <= 0:
					_stop_chasing()
			else:
				follow_timer = follow_time
		State.ATTACK:
			_try_attack(delta)


func _stop_chasing():
	state = State.IDLE


func _process_movement(delta):
	nav_agent.set_target_position(Global.player.global_position)
	var next_nav_point = nav_agent.get_next_path_position()
	var new_velocity = (next_nav_point - global_position + Vector3(0.2,0,0).rotated(Vector3.UP,randf()*PI)).normalized() * speed
	velocity.x = new_velocity.x
	velocity.z = new_velocity.z
	rotation.y = PI/2 + \
	-Vector2(global_position.x, global_position.z).angle_to_point(
	 Vector2(next_nav_point.x, next_nav_point.z)
	)
	move_and_slide()


func _look_for_player():
	if blind: return
	if global_position.distance_to(Global.player.global_position) > follow_range: return
	if not _sees_player(): return
	_notice_player()


func _sees_player():
	vision_raycast.rotation.y = -rotation.y
	vision_raycast.target_position = (Global.player.global_position + Vector3.UP*0.5 - vision_raycast.global_position) * 1000000.0
	vision_raycast.force_raycast_update()
	return vision_raycast.is_colliding() and vision_raycast.get_collider() is Player


func _notice_player():
	audioplayer.play()
	noticed_player.emit()
	_start_chasing()


func _start_chasing():
	state = State.CHASE


func _is_in_attack_range():
	return global_position.distance_to(Global.player.global_position) < attack_range


func _start_attacking():
	state = State.ATTACK


func _try_attack(delta):
	if not _is_in_attack_range():
		_start_chasing()
	if attack_timer <= 0.0:
		attack(damage)
		attack_timer = attack_cooldown


func hit():
	health -= 1
	var instance = blood_splatter.instantiate()
	instance.position = global_position-Vector3(0.0,0.0,0.0)#Vector3(self.global_position.x,0.51,self.global_position.z)
	instance.rotation_degrees.y = randf()*360.0
	get_tree().current_scene.add_child(instance)
	
	if health <= 0:
		death()


func attack(damage):
	rotation.y = PI/2 + \
	-Vector2(global_position.x, global_position.z).angle_to_point(
	 Vector2(Global.player.global_position.x, Global.player.global_position.z)
	)
	attacked_player.emit()
	Global.player.hit(damage)


func death():
	Global.play_sound(death_sound)
	died.emit()
	queue_free()


func play_sound():
	audioplayer.play()
