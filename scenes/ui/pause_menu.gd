extends CanvasLayer

@onready var panel_container = $%PanelContainer

var is_closing: bool = false
var options_menu_scene = preload("res://scenes/ui/options_menu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	panel_container.pivot_offset = panel_container.size / 2
	$%ResumeButton.pressed.connect(on_resume_pressed)	
	$%OptionsButton.pressed.connect(on_options_pressed)
	$%QuitToMenuButton.pressed.connect(on_quit_to_menu_pressed)
	
	$AnimationPlayer.play("default")
	
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0.0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)

func on_resume_pressed():
	close()

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		close()
		get_tree().root.set_input_as_handled()

func close():
	if is_closing:
		return
	is_closing = true
	$AnimationPlayer.play_backwards("default")
	
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.0)
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0.3)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	await tween.finished
	
	get_tree().paused = false
	queue_free()

func on_options_pressed():
	var option_menu_instance = options_menu_scene.instantiate()
	add_child(option_menu_instance)
	option_menu_instance.back_pressed.connect(on_options_back_pressed.bind(option_menu_instance))

func on_quit_to_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
	
func on_options_back_pressed(options_menu_instance: Node):
	options_menu_instance.queue_free()
