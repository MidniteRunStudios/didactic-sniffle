extends Area2D
class_name HurtboxComponent

@export var health_component: Node

var floating_textbox_scene = preload("res://scenes/ui/floating_text.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(on_area_entered) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_area_entered(other_area: Area2D):
	if not other_area is HitboxComponent:
		return
	if health_component == null:
		return
	var hitbox_component = other_area as HitboxComponent
	health_component.damage(hitbox_component.damage)
	
	var floating_text_instance = floating_textbox_scene.instantiate() as Node2D
	get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text_instance)
	floating_text_instance.global_position = global_position + (Vector2.UP * 16)
	floating_text_instance.start(str(hitbox_component.damage))
