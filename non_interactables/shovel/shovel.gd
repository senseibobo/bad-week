extends Node3D


signal attacked

var hit_shape_cast: ShapeCast3D

@onready var ricochet_sound_player: AudioStreamPlayer = $Ricochet


func _ready():
	update(false)
	await get_tree().process_frame
	hit_shape_cast = Global.player.attack_shape_cast
	

func hit():
	if hit_shape_cast.get_collision_count() > 0:
		var collider = hit_shape_cast.get_collider(0)
		if collider is Enemy:
			collider.hit()
			Global.player.blood_particle.emitting = true
			# TODO particles
		else:
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
