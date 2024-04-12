extends CanvasLayer


signal transitioned


var transition_time: float = 0.5
var transitioning: bool = false


func _ready():
	$ColorRect.color.a = 0.0


func transition(
	time: float = transition_time,
	start_color: Color = Color(0,0,0,0), 
	end_color: Color = Color(0,0,0,1),
	wait: float = 0.2
	):
	$ColorRect.color = start_color
	var tween = create_tween()
	tween.tween_property($ColorRect, "color", end_color, time)
	if wait > 0.0:
		tween.tween_interval(wait)
	tween.tween_callback(emit_signal.bind("transitioned"))
	tween.tween_property($ColorRect, "color:a", 0.0, time)
		


func transition_to(
	file: String, 
	time: float = transition_time, 
	start_color: Color = Color(0,0,0,0), 
	end_color: Color = Color(0,0,0,1),
	wait: float = 0.2
	):
	if transitioning: return
	if time > 0:
		transitioning = true
		transition(time,start_color,end_color,wait)
		await transitioned
		transitioning = false
	get_tree().change_scene_to_file(file)
