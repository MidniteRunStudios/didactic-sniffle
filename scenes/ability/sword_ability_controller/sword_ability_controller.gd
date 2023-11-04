extends Node

@export var sword_ability: PackedScene
@export var max_range: = 150
var damage = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(on_timer_timeout) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if(player == null):
		return
		
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func(enemy:Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) <= pow(max_range, 2)
	)
	
	if(enemies.size() == 0):
		return
		
	enemies.sort_custom(func(a: Node2D,b:Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	
	var sword_instance = sword_ability.instantiate() as SwordAbility
	player.get_parent().add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage
	sword_instance.global_position = enemies[0].global_position
	#Vector2.RIGHT = 0 then rotate randomly between 0 and 2PI with offset 4
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemy_position = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_position.angle()
