extends Node
class_name HealthComponent

@export var max_health: float = 10
var current_health: float

signal died
signal health_changed
signal health_decreased

func _ready():
	current_health = max_health

func damage(damage_amount: float):
	current_health = max(current_health - damage_amount, 0)
	health_changed.emit()
	if damage_amount > 0:
		health_decreased.emit()
	Callable(check_death).call_deferred()

func heal(heal_amount: int):
	damage(-heal_amount)

func get_health_percent():
	if max_health <= 0:
		return 0
	return min(current_health / max_health, 1)

func check_death():
	if current_health == 0:
		died.emit()
		owner.queue_free()

