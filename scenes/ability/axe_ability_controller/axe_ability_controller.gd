extends Node

@export var axe_ability_scene: PackedScene
var base_damage = 10
var additional_damage_percent = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_added)
 # Replace with function body.

func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var foreground = get_tree().get_first_node_in_group("foreground_layer") as Node2D
	if foreground == null:
		return
		
	var axe_ability_instance = axe_ability_scene.instantiate() as Node2D
	foreground.add_child(axe_ability_instance)
	axe_ability_instance.global_position = player.global_position
	axe_ability_instance.hitbox_component.damage = base_damage * additional_damage_percent

func on_ability_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "axe_damage":
		additional_damage_percent = 1 + (current_upgrades["axe_damage"]["quantity"] * 0.1)

