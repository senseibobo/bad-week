extends CharacterBody3D


@export var speed: float = 10.0
var mom: Node3D

@onready var target: Node3D


func _ready():
	Global.enemies.append(self)


func _exit_tree():
	Global.enemies.erase(self)


func _physics_process(delta):
	var target_pos = target.global_position + Vector3.UP*1.5
	look_at(target_pos)
	velocity = global_position.direction_to(target_pos)*speed
	move_and_slide()
	if global_position.distance_to(target_pos) < 1.0:
		queue_free()
		target.hit(30)
		Global.play_sound_3d(preload("res://sounds/eye_explode.ogg"),global_position)
	


func hit():
	$DeflectSound.play()
	$SiktanjeSound.volume_db -= 6.0
	target = mom.target_spot
