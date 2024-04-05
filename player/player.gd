class_name Player
extends CharacterBody3D


@export var movement_speed: float = 3.5
@export var sprint_multiplier: float = 1.5
@export var sensitivity: float = 0.6
@export var max_health: float = 100
@export var has_shovel: bool = false:
	set(value):
		has_shovel = value
		shovel.update(has_shovel)
	get:
		return has_shovel
		
		
var has_key: bool = false
var has_pills: bool = false
var has_letter: bool = false
const JUMP_VELOCITY = 6.5
var gravity = 30.0
var note_timer: float = 0.0

@onready var camera: Camera3D = $Camera3D
@onready var interact_raycast: RayCast3D = $Camera3D/InteractRaycast
@onready var hud: CanvasLayer = $HUD
@onready var interact_label: Label = $HUD/InteractLabel
@onready var attack_hitbox: Area3D = $Camera3D/AttackHitbox
@onready var blood_hp_indicator: ColorRect = $HUD/Blood
@onready var health: float = max_health
@onready var blood_particle = $BloodParticle
@onready var shovel: Node3D = $HUD/SubViewportContainer/SubViewport/Shovel
@onready var note_label: Label = $HUD/NoteLabel


func _ready():
	Global.player = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_update_blood_hp_indicator()
	_update_shovel()


func _physics_process(delta):
	_process_movement(delta)


func _process(delta):
	_process_interacting()
	_process_note(delta)


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		camera.rotate_x(-sensitivity*event.relative.y/100.0)
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)
		rotate_y(-sensitivity*event.relative.x/100.0)


func _process_note(delta):
	note_timer -= delta
	if note_timer <= 0.0:
		note_label.visible = false


func _process_interacting():
	interact_label.visible = interact_raycast.is_colliding() and interact_raycast.get_collider() is Interactable
	if Input.is_action_just_pressed("interact") and interact_raycast.is_colliding() and interact_raycast.get_collider() is Interactable:
		interact()

func _process_movement(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var input_dir = Input.get_vector(
		"move_left", "move_right", "move_forward", "move_backward"
		)
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var v1 = Vector2(velocity.x, velocity.z)
	var v2 = Vector2(direction.x, direction.z) * movement_speed
	if Input.is_action_pressed("sprint"):
		v2 *= sprint_multiplier
	var v3 = lerp(v1, v2, 8.0*delta)
	velocity = Vector3(v3.x, velocity.y, v3.y)
	

	move_and_slide()
	
	if position.y < -20.0:
		death()


func deal_damage():
	for body in attack_hitbox.get_overlapping_bodies():
		body.hit()
		blood_particle.emitting = true

func interact():
	var interactable: Interactable = interact_raycast.get_collider()
	interactable.on_interact(self)


func hit(damage: float):
	health -= damage
	_update_blood_hp_indicator()
	if health <= 0:
		death()


func heal(amount: float):
	health += amount


func death():
	Global.old_scene = get_tree().current_scene.scene_file_path
	Transition.transition_to("res://levels/level0/death_room.tscn")
	

func pick_up_key():
	has_key = true
	
	
func take_pills():
	has_pills = true


func take_letter():
	has_letter = true
	
	
func show_message(text: String, time: float = 4.0):
	note_timer = time
	note_label.visible = true
	note_label.text = text


func _update_shovel():
	shovel.update(has_shovel)


func _update_blood_hp_indicator():
	blood_hp_indicator.material.set("shader_parameter/strength",1.0-health/max_health)
