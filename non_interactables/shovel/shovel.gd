extends Node3D


signal attacked

var hit_shape_cast: ShapeCast3D
@export var ignore_walls: bool = false

@onready var ricochet_sound_player: AudioStreamPlayer = $Ricochet


func _ready():
	update(false)
	await get_tree().process_frame
	hit_shape_cast = Global.player.attack_shape_cast
	

func hit():
	var colliders: Array
	for i in hit_shape_cast.get_collision_count():
		var collider = hit_shape_cast.get_collider(i)
		if is_instance_valid(collider):
			colliders.append(collider)
	
	if colliders.size() > 0:
		var raycast_target = Global.player.attack_ray_cast.get_collider()
		if colliders[0].has_method("hit"):
			colliders[0].hit()
			Global.player.blood_particle.emitting = true
		elif is_instance_valid(raycast_target) and raycast_target.has_method("hit"):
			raycast_target.hit()
			Global.player.blood_particle.emitting = true
		elif not ignore_walls:
			$AnimationPlayer.play("ricochet")
			ricochet_sound_player.play()
			var p = $GPUParticles3D.duplicate(false)
			get_tree().current_scene.add_child(p)
			p.emitting = true
			p.global_position = hit_shape_cast.get_collision_point(0)
			p.finished.connect(p.queue_free)

func _unhandled_input(event):
	if Input.is_action_just_pressed("attack") and not $AnimationPlayer.is_playing() and visible:
		attack()


func attack():
	$AnimationPlayer.play("new_attack")


func update(has_shovel):
	var play_animation = false
	if not visible and has_shovel:
		play_animation = true
	visible = has_shovel
	set_process(has_shovel)
	set_physics_process(has_shovel)
	set_physics_process_internal(has_shovel)
	if play_animation:
		$lopata.position.y = -0.8
		var tween = create_tween()
		tween.tween_property($lopata, "position:y", 0.0, 0.5)
