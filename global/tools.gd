extends Node

func timer(time: float, node: Node = null):
	var timer = Timer.new()
	if node:
		node.add_child(timer)
	else:
		add_child(timer)
	timer.timeout.connect(timer.queue_free)
	timer.start(time)
	return timer.timeout
