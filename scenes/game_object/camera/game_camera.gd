extends Camera2D

var target_position = Vector2.ZERO
var smoothing_weight = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	make_current() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	aquire_target()
	# study lerp
	# lerping is when you need to transition to a point.
	# point a and point b, lerping lets you go a percentage between the point
	# percentage is calculated by 100% subtract the exponent of -time multiplied by smoothing weight
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * smoothing_weight))

func aquire_target():
	var player_nodes: Array[Node] = get_tree().get_nodes_in_group("player")
	if player_nodes.size() > 0:
		var player = player_nodes[0] as Node2D
		target_position = player.global_position
