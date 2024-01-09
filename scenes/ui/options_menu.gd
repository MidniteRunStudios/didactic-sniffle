extends CanvasLayer

@onready var window_button: Button = $%WindowModeButton
@onready var sfx_slider = $%SfxSlider
@onready var music_slider = $%MusicSlider
@onready var random_sound_test_component = $RandomSoundTestComponent
@onready var back_button = %BackButton

signal back_pressed

const BUS_NAME_SFX: String = "SFX"
const BUS_NAME_MUSIC: String = "Music"
# Called when the node enters the scene tree for the first time.
func _ready():
	window_button.pressed.connect(on_window_button_pressed)
	sfx_slider.value_changed.connect(on_audio_changed.bind(BUS_NAME_SFX))
	music_slider.value_changed.connect(on_audio_changed.bind(BUS_NAME_MUSIC))
	back_button.pressed.connect(on_back_button_pressed)
	update_display()
	
func on_window_button_pressed():
	var mode = DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	update_display()

func update_display():
	window_button.text = "Windowed"
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			window_button.text = "Fullscreen"
	sfx_slider.value = get_bus_volume_percent(BUS_NAME_SFX)
	music_slider.value = get_bus_volume_percent(BUS_NAME_MUSIC)

func get_bus_volume_percent(bus_name: String):
	var bus_index = AudioServer.get_bus_index(bus_name)
	var volumn_db = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(volumn_db)

func set_bus_volume_percent(bus_name: String, percent: float):
	var bus_index = AudioServer.get_bus_index(bus_name)
	var volumn_db = linear_to_db(percent)
	AudioServer.set_bus_volume_db(bus_index,volumn_db)

func on_audio_changed(value: float,bus_name: String):
	set_bus_volume_percent(bus_name, value)
	if bus_name == BUS_NAME_SFX:
		random_sound_test_component.play_random()
		

func on_back_button_pressed():
	SceneTransition.transition()
	await SceneTransition.transitioned_halfway
	back_pressed.emit()
