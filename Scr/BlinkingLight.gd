extends Light2D

func _on_Timer_timeout():
	get_node("Timer").start((randi()%100)*0.01)
	visible = !visible
