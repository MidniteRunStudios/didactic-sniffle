extends CharacterBody2D

@export var max_speed = 40
@onready var health_component: HealthComponent = $HealthComponent

func _process(_delta):
	var direction = get_player_direction()
	velocity = direction * max_speed
	move_and_slide()

func get_player_direction():
	var player_nodes = get_tree().get_first_node_in_group("player") as Node2D
	if  player_nodes != null:
		return (player_nodes.global_position - global_position).normalized()
	return Vector2.ZERO
