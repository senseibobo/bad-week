extends StateMachine

var player: Player
var timer: float = 0.0


func _ready():
	var parent = get_parent()
	var player = Global.player
	#call_deferred("_set_state", State.FOLLOW)


func _state_logic(delta):
	if state == State.FOLLOW:
		parent.follow()
	if state == State.ATTACK:
		if timer <= 0:
			parent.attack(parent.damage)
			timer = parent.attack_cooldown
		else:
			timer -= delta
	if state == State.DEAD:
		parent.die()


func _get_transition(delta):
	match state:
		State.IDLE:
			if parent.should_follow():
				return State.FOLLOW
			if parent.is_dead():
				return State.DEAD
		State.FOLLOW:
			if parent.should_attack():
				return State.ATTACK
			if parent.is_dead():
				return State.DEAD
		State.ATTACK:
			if parent.should_follow():
				return State.FOLLOW
			if parent.is_dead():
				return State.DEAD


func _enter_state(new_state, old_state):
	if old_state == State.IDLE:
		get_parent().emit_signal("noticed_player")
		parent.play_sound()
	#match new_state:
		#states.idle:
			#parent.animation_player.play("idle")
		#states.follow:
			#parent.animation_player.play("follow")
		#states.attack:
			#parent.animation_player.play("attack")
		#states.dead:
			#parent.animation_player.play("dead")
	pass


func _exit_state(old_state, new_state):
	pass


func _process(delta):
	pass
