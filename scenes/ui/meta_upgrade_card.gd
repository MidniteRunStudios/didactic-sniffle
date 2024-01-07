extends PanelContainer


@onready var name_label: Label = $%NameLabel
@onready var description_label: Label = $%DesciptionLabel
@onready var purchase_button = $%PurchaseButton
@onready var progress_bar = $%ProgressBar
@onready var progress_label = %ProgressLabel
@onready var total_count_label = %TotalCountLabel



var upgrade: MetaUpgrade

func _ready():
	purchase_button.pressed.connect(on_purchase_button_pressed)

func set_meta_upgrade(upgrade: MetaUpgrade):
	self.upgrade = upgrade
	name_label.text = upgrade.title
	description_label.text = upgrade.description
	update_progress()


func select_card():
	$AnimationPlayer.play("selected")
	await $AnimationPlayer.animation_finished
	
func on_purchase_button_pressed():
	if upgrade == null:
		return
	MetaProgression.add_meta_upgrade(upgrade)
	MetaProgression.save_data["meta_upgrade_currency"] -= upgrade.experience_cost
	MetaProgression.save()
	get_tree().call_group("meta_upgrade_card", "update_progress")
	select_card()


func update_progress():
	var currency = MetaProgression.save_data["meta_upgrade_currency"]
	var current_quantity = 0
	if MetaProgression.save_data["meta_upgrades"].has(upgrade.id):
		current_quantity = MetaProgression.save_data["meta_upgrades"][upgrade.id]["quantity"]
	var percent = currency / upgrade.experience_cost
	percent = min(percent, 1)
	progress_bar.value = percent
	purchase_button.disabled = percent < 1
	progress_label.text = str(currency) + "/" + str(upgrade.experience_cost)

	total_count_label.text = "x%d" % current_quantity
	if current_quantity == upgrade.max_quantity:
		progress_label.text = "Maxed Out"
