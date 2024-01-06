extends CanvasLayer

signal transitioned_halfway
var skip_emit: bool = false
func transition():
	$AnimationPlayer.play("default")
	await transitioned_halfway
	skip_emit = false
	$AnimationPlayer.play_backwards("default")


func emit_transitioned_halfway():
	if skip_emit:	
		skip_emit = false	
		return
	transitioned_halfway.emit()
	skip_emit = true
