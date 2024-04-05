extends Node3D


signal attacked

var hit_area: Area3D

func _ready():
	update(false)
	await get_tree().process_frame
	hit_area = Global.player.attack_hitbox
	attacked.connect(Global.player.deal_damage)
	

func hit():
	for body in hit_area.get_overlapping_bodies():
		body.hit()


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
