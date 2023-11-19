extends PanelContainer

signal selected

@onready var name_label: Label = $%NameLabel
@onready var description_label: Label = $%DesciptionLabel

func _ready():
	gui_input.connect(_on_gui_input)

func set_ability_upgrade(ability: AbilityUpgrade):
	name_label.text = ability.name
	description_label.text = ability.description


func _on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		selected.emit()
