extends PanelContainer

@onready var name_label: Label = $%NameLabel
@onready var description_label: Label = $%DesciptionLabel

func set_ability_upgrade(ability: AbilityUpgrade):
	name_label.text = ability.name
	description_label.text = ability.description
