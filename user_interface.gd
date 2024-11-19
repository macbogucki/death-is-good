extends Control

@onready var bind_to_change = "nothing"
@onready var notabandoned = false
@onready var ustawienia_open = false
@onready var game_container = $GameContainer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if bind_to_change != "nothing":
		if event is InputEventKey and event.pressed and notabandoned == true:
			InputMap.action_erase_events(bind_to_change)
			InputMap.action_add_event(bind_to_change,event)
			if bind_to_change == "MoveUp":
				$Ustawienia/Controls/up_bind.text = event.as_text()
			if bind_to_change == "MoveDown":
				$Ustawienia/Controls/down_bind.text = event.as_text()
			if bind_to_change == "MoveLeft":
				$Ustawienia/Controls/left_bind.text = event.as_text()
			if bind_to_change == "MoveRight":
				$Ustawienia/Controls/right_bind.text = event.as_text()
			if bind_to_change == "Interaction":
				$Ustawienia/Controls/interaction_bind.text = event.as_text()
			bind_to_change = "nothing"
			$Ustawienia/Controls/change_bind.hide()
	
	
func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),value)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),value)


func _on_up_bind_button_pressed() -> void:
	notabandoned = true
	$Ustawienia/Controls/change_bind/Label.text = "Press a new key for move up action"
	$Ustawienia/Controls/change_bind.show()
	bind_to_change="MoveUp"


func _on_down_bind_button_pressed() -> void:
	notabandoned = true
	$Ustawienia/Controls/change_bind/Label.text = "Press a new key for move down action"
	$Ustawienia/Controls/change_bind.show()
	bind_to_change="MoveDown"


func _on_left_bind_button_pressed() -> void:
	notabandoned = true
	$Ustawienia/Controls/change_bind/Label.text = "Press a new key for move left action"
	$Ustawienia/Controls/change_bind.show()
	bind_to_change="MoveLeft"


func _on_right_bind_button_pressed() -> void:
	notabandoned = true
	$Ustawienia/Controls/change_bind/Label.text = "Press a new key for move right action"
	$Ustawienia/Controls/change_bind.show()
	bind_to_change="MoveRight"


func _on_interaction_bind_button_pressed() -> void:
	notabandoned = true
	$Ustawienia/Controls/change_bind/Label.text = "Press a new key for interaction action"
	$Ustawienia/Controls/change_bind.show()
	bind_to_change="Interaction"


func _on_settings_button_2_pressed() -> void:
	$Ustawienia/Controls.hide()
	$Ustawienia/Settings.show()
	notabandoned = false
	$Ustawienia/Controls/change_bind.hide()


func _on_contols_button_pressed() -> void:
	$Ustawienia/Settings.hide()
	$Ustawienia/Controls.show()
	notabandoned = false
	$Ustawienia/Controls/change_bind.hide()


func _on_close_button_pressed() -> void:
	notabandoned = false
	$Ustawienia/Controls/change_bind.hide()
	$Ustawienia.hide()
	ustawienia_open=false

func _on_settings_button_pressed() -> void:
	ustawienia_open = not ustawienia_open
	if ustawienia_open==true:
		$Ustawienia.show()
		$Ustawienia/Settings.show()
		$Ustawienia/Controls.hide()
	else:
		$Ustawienia.hide()


func _on_button_pressed() -> void:
	game.unlocked += 1
	


func _on_przycisk_start_pressed() -> void:
	$menu_levels.show()
	$menu_start.hide()

func load_new_scene():
	$menu_levels.hide()
	print(game.level)
	var scene_path = "res://levels/level"+str(game.level)+".tscn"
	for child in game_container.get_children():
		child.queue_free()
	
	# Załaduj nową scenę i dodaj jako dziecko
	var new_scene = load(scene_path).instantiate()
	game_container.add_child(new_scene)
	$wroc.show()

func _on_texture_button_pressed() -> void:
	game.level=1
	load_new_scene()
	print("h")
	


func _on_menu_levels_visibility_changed() -> void:
	for i in range(game.unlocked): 
		i = i+1;
		var control_panel = $menu_levels.get_node("PanelContainer" + str(i))
		control_panel.get_node("TextureButton").show()
		control_panel.get_node("Label").show()
		control_panel.get_node("TextureRect").hide()
		


func _on_texture_button_pressed2() -> void:
	game.level=2
	load_new_scene()


func _on_back_start_button_pressed() -> void:
	$menu_start.show()
	$menu_levels.hide()


func _on_texture_button_pressed3() -> void:
	game.level=3
	load_new_scene()


func _on_texture_button_pressed4() -> void:
	game.level=4
	load_new_scene()


func _on_texture_button_pressed5() -> void:
	game.level=5
	load_new_scene()


func _on_wroc_pressed() -> void:
	$menu_levels.show()
	for child in game_container.get_children():
		child.queue_free()
	$wroc.hide()
	
