extends Node

@export var end_screen_scene: PackedScene
@onready var timer: Timer = $Timer

func _ready():
	$Timer.timeout.connect(on_timer_timeout)
# Called when the node enters the scene tree for the first time.
func get_time_elasped():
	return timer.wait_time - timer.time_left
func on_timer_timeout():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
