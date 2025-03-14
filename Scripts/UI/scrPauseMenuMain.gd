extends Control

@export_file("*.tscn") var main_menu: String

var items_menu := preload("res://Objects/UI/objPauseMenuItems.tscn")
var button_color_unfocused: Color = Color(0, 0, 0)


# Loads and sets values, gives focus, sets button labels and colors
func _ready():
	
	# Pauses the game
	GLOBAL_GAME.game_paused = true
	get_tree().set_pause(true)

	# Sets text and color for the button labels
	set_labels_text()
	
	# Changes text and color_unfocused for each button inside the options
	# container. Keep in mind, we get the "node_path + /Label" to change
	# each label's colors on creation. Afterwards, we set color_unfocused
	# to each node, so they change on their own
	for options_container_buttons in $CanvasLayer/VBoxContainer/OptionsContainer.get_children():
		
		set_button_colors(options_container_buttons.get_node("Label"))
		options_container_buttons.color_unfocused = button_color_unfocused
	
	# Sets focus to the first option (we do this after setting the button's
	# colors. Otherwise, the focus color will get overwritten)
	$CanvasLayer/VBoxContainer/OptionsContainer/ItemsMenu.grab_focus()


# Goes back to the main menu room if "button_shoot" is pressed
func _physics_process(_delta):
	
	# Sets and updates the text from each one of the button's labels
	set_labels_text()
	
	if Input.is_action_just_pressed("button_pause"):
		quit_pause()



# Items menu
func _on_items_menu_pressed():
	if items_menu != null:
		var items_menu_instance = items_menu.instantiate()
		add_sibling(items_menu_instance)
		
		# Play sound and destroy itself
		GLOBAL_SOUNDS.play_sound(GLOBAL_SOUNDS.sndPause)
		queue_free()


# Music volume
func _on_music_volume_gui_input(_event):
	if Input.is_action_just_pressed("ui_right"):
		GLOBAL_SETTINGS.inc_setting("music_volume")
	if Input.is_action_just_pressed("ui_left"):
		GLOBAL_SETTINGS.dec_setting("music_volume")

# Sound volume
func _on_sound_volume_gui_input(_event):
	if Input.is_action_just_pressed("ui_right"):
		GLOBAL_SETTINGS.inc_setting("sound_volume")
	if Input.is_action_just_pressed("ui_left"):
		GLOBAL_SETTINGS.dec_setting("sound_volume")


# Quit to menu
func _on_quit_to_menu_pressed():
	quit_pause()
	
	GLOBAL_GAME.triggered_events.clear()
	GLOBAL_GAME.dialog_events.clear()
	GLOBAL_SAVELOAD.itemsGameData.clear()
	get_tree().change_scene_to_file(main_menu)


# Resume game
func _on_resume_game_pressed():
	quit_pause()



# Updates text labels to show the proper key ids
func set_labels_text():
	$CanvasLayer/VBoxContainer/OptionsContainer/ItemsMenu/Label.text = "View Items"
	$CanvasLayer/VBoxContainer/OptionsContainer/MusicVolume/Label.text = (
		"Music Volume: " + str(
			round(GLOBAL_SETTINGS.get_setting("music_volume") * 100)
		) + "%"
	)
	$CanvasLayer/VBoxContainer/OptionsContainer/SoundVolume/Label.text = (
		"Sound Volume: " + str(
			round(GLOBAL_SETTINGS.get_setting("sound_volume") * 100)
		) + "%"
	)
	$CanvasLayer/VBoxContainer/OptionsContainer/QuitToMenu/Label.text = "Quit to Main Menu"
	$CanvasLayer/VBoxContainer/OptionsContainer/ResumeGame/Label.text = "Resume"


# Sets the color of the button outlines when unfocused.
# Just a personal preference, and lazily made
func set_button_colors(button_id):
	button_id.set("theme_override_colors/font_outline_color", button_color_unfocused)


# Called when quitting the pause menus
func quit_pause():
	
	# Save settings
	GLOBAL_SETTINGS.save_settings()
	
	# Unset pause, unpause game
	GLOBAL_GAME.game_paused = false
	get_tree().set_pause(false)
	
	# Destroy itself
	queue_free()
