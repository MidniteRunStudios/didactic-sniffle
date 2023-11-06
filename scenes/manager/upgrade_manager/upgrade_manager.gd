extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var exp_manager: Node

var current_upgrades = {}

func _ready():
	exp_manager.level_up.connect(on_level_up)
	
func on_level_up(current_level:int):
	var chosen_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	if chosen_upgrade == null:
		return
		
	var has_upgrades = current_upgrades.has(chosen_upgrade.id)
	if !has_upgrades:
		current_upgrades[chosen_upgrade.id] = {
			"resource": chosen_upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[chosen_upgrade.id]["quantity"] += 1
	