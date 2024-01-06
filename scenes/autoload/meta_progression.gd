extends Node

var save_data: Dictionary = {
	"meta_upgrade_currency": 0,
	"meta upgrades": {}
}

func _ready():
	GameEvents.experience_vial_collected.connect(on_exp_vial_collected)
	
func add_meta_upgrade(upgrade: MetaUpgrade):
	save_data

func on_exp_vial_collected(experience: float):
	save_data["meta_upgrade_currency"] += experience
	
