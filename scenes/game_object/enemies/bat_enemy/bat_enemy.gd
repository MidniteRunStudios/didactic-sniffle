extends CharacterBody2D

@onready var visuals = $Visuals
@onready var velocity_component = $VelocityComponent

var is_moving: bool = false

func _ready():
		$HurtBoxComponent.hit.connect(on_hit)

func _process(_delta):
	velocity_component.accelarate_to_player()
	velocity_component.move(self)
	
	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)

func on_hit():
	$HitRandomAudioPlayer.play_random()
