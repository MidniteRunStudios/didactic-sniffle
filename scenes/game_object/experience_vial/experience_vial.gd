extends Node2D

@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var sprite = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.area_entered.connect(on_area_entered) # Replace with function body.

func on_area_entered(_other_area: Area2D):
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_method(tween_collect.bind(global_position),0.0,1.0,0.5)\
	.set_ease(Tween.EASE_IN)\
	.set_trans(Tween.TRANS_BACK)
	tween.tween_property(sprite, "scale", Vector2.ZERO, 0.10).set_delay(0.40)
	tween.chain()
	tween.tween_callback(collect)
	$RandomAudioStreamPlayer2DComponent.play_random()
	
func disable_collision():
	collision_shape_2d.disabled = true

func collect():
	GameEvents.emit_experience_vial_collected(1)
	queue_free()

func tween_collect(percent:float, start_position: Vector2):
# You cannot disable collisions during collision checks. Defer the call to disable.
	Callable(disable_collision).call_deferred()
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	global_position = start_position.lerp(player.global_position,percent)
	var direction_from_start = player.global_position - start_position
	var target_rotation = direction_from_start.angle() + rad_to_deg(90)
	rotation = lerp_angle(rotation, target_rotation, 1 - exp(2 * -get_process_delta_time()))
