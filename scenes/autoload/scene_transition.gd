extends CanvasLayer

signal transitioned_halfway
var skip_emit: bool = false

func transition():
	$AnimationPlayer.play("default")
	await transitioned_halfway
	skip_emit = true
	$AnimationPlayer.play_backwards("default")


func emit_transitioned_halfway():
	if skip_emit:	
		skip_emit = false	
		return
	transitioned_halfway.emit()

func transition_to_scene(path: String):
	transition()
	await transitioned_halfway
	get_tree().change_scene_to_file(path)
