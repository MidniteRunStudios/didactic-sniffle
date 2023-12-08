extends Node

@export var victory_screen_scene: PackedScene
@onready var timer: Timer = $Timer

func _ready():
	$Timer.timeout.connect(on_timer_timeout)
# Called when the node enters the scene tree for the first time.
func get_time_elasped():
	return timer.wait_time - timer.time_left
func on_timer_timeout():
	var victory_screen_instance = victory_screen_scene.instantiate()
	add_child(victory_screen_instance)
