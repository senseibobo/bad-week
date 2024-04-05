extends Interactable


signal fixed


@export var on: bool = true
@export var flickering: bool = true
@onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready():
	if not on:
		turn_off()
	elif flickering:
		flicker()
	else:
		turn_on()
		anim_player.queue_free()


func flicker():
	await get_tree().create_timer(randf()*2.0)
	anim_player.play("flicker")
	on = true
	flickering = true
	set("collision_layer", 4)


func turn_on():
	$AudioStreamPlayer3D.stop()
	anim_player.play("turn_on")
	on = true
	set("collision_layer", 0)
	flickering = false
	


func turn_off():
	$AudioStreamPlayer3D.stop()
	anim_player.play("turn_off")
	set("collision_layer", 0)
	on = false


func on_interact(player):
	if on and flickering and player.lamps > 0:
		player.lamps -= 1
		turn_on()
		fixed.emit()
