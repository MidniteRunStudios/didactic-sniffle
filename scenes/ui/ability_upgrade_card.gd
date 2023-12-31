extends PanelContainer

signal selected

@onready var name_label: Label = $%NameLabel
@onready var description_label: Label = $%DesciptionLabel

var disabled = false

func _ready():
	gui_input.connect(_on_gui_input)
	mouse_entered.connect(on_mouse_entered)

func set_ability_upgrade(ability: AbilityUpgrade):
	name_label.text = ability.name
	description_label.text = ability.description


func _on_gui_input(event: InputEvent):
	if disabled:
		return
	if event.is_action_pressed("left_click"):
		select_card()
		discard_other_cards()

func play_in(delay:float = 0):
	modulate = Color.TRANSPARENT
	await get_tree().create_timer(delay).timeout
	$AnimationPlayer.play("in")

func play_discard():
	$AnimationPlayer.play("discard")

func select_card():
	disabled = true
	$AnimationPlayer.play("selected")
	await $AnimationPlayer.animation_finished
	selected.emit()
	
func discard_other_cards():
	for other_card in get_tree().get_nodes_in_group("upgrade_card"):
		if other_card == self:
			continue
		other_card.play_discard()

func on_mouse_entered():
	if disabled:
		return
	$HoverAnimationPlayer.play("hover")
