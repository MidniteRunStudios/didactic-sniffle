extends Node

@onready var timer: Timer = $Timer
# Called when the node enters the scene tree for the first time.
func get_time_elasped():
	return timer.wait_time - timer.time_left
