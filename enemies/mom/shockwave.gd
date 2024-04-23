extends Area3D


@export var damage: float = 20.0
@export var knockup: float = 17.0

@onready var shape: CollisionShape3D = $CollisionShape3D
@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var explosion: MeshInstance3D = $Explosion

# Called when the node enters the scene tree for the first time.
func _ready():
	shape.shape = shape.shape.duplicate()
	global_position.y = -1
	mesh.material_override = mesh.material_override.duplicate()
	explosion.material_override = explosion.material_override.duplicate()
	$AnimationPlayer.play("shockwave")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	var r = shape.shape.radius
	r -= 2.0
	var pos = Vector2(
		global_position.x, 
		global_position.z
	)
	var player_pos = Vector2(
		Global.player.global_position.x, 
		Global.player.global_position.z
	)
	if pos.distance_to(player_pos) > r:
		Global.player.hit(damage)
		Global.player.velocity.y += knockup
