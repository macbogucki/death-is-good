extends Control

@onready var bind_to_change = "nothing"
@onready var notabandoned = false
@onready var ustawienia_open = false
@onready var game_container = $GameContainer
@onready var lang = "english"
var custom_cursor = preload("res://assets/interface/cursor_image.svg")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_custom_mouse_cursor(custom_cursor, Input.CURSOR_ARROW)
	for i in range(11):
		if i>game.number_of_levels:
			$menu_levels.get_node("PanelContainer" + str(i)).hide()


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
	if lang == "english": $Ustawienia/Controls/change_bind/Label.text = "Press a new key for move up action"
	else: $Ustawienia/Controls/change_bind/Label.text = "Wybierz nowy klawisz dla akcji idź w górę"
	$Ustawienia/Controls/change_bind.show()
	bind_to_change="MoveUp"


func _on_down_bind_button_pressed() -> void:
	notabandoned = true
	if lang == "english": $Ustawienia/Controls/change_bind/Label.text = "Press a new key for move down action"
	else: $Ustawienia/Controls/change_bind/Label.text = "Wybierz nowy klawisz dla akcji idź w dół"
	$Ustawienia/Controls/change_bind.show()
	bind_to_change="MoveDown"


func _on_left_bind_button_pressed() -> void:
	notabandoned = true
	if lang == "english": $Ustawienia/Controls/change_bind/Label.text = "Press a new key for move left action"
	else: $Ustawienia/Controls/change_bind/Label.text = "Wybierz nowy klawisz dla akcji idź w lewo"
	$Ustawienia/Controls/change_bind.show()
	bind_to_change="MoveLeft"


func _on_right_bind_button_pressed() -> void:
	notabandoned = true
	if lang == "english": $Ustawienia/Controls/change_bind/Label.text = "Press a new key for move right action"
	else: $Ustawienia/Controls/change_bind/Label.text = "Wybierz nowy klawisz dla akcji idź w prawo"
	$Ustawienia/Controls/change_bind.show()
	bind_to_change="MoveRight"


func _on_interaction_bind_button_pressed() -> void:
	notabandoned = true
	if lang == "english": $Ustawienia/Controls/change_bind/Label.text = "Press a new key for interaction action"
	else: $Ustawienia/Controls/change_bind/Label.text = "Wybierz nowy klawisz dla akcji interakcja"
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
	game.setGrid()
	$ruchy.show()

func _on_texture_button_pressed() -> void:
	game.level=0
	game.changeLevel()
	


func _on_menu_levels_visibility_changed() -> void:
	for i in range(game.unlocked): 
		i = i+1;
		if i <= game.number_of_levels:
			var control_panel = $menu_levels.get_node("PanelContainer" + str(i))
			control_panel.get_node("TextureButton").show()
			control_panel.get_node("Label").show()
			control_panel.get_node("TextureRect").hide()
		


func _on_texture_button_pressed2() -> void:
	game.level=1
	game.changeLevel()


func _on_back_start_button_pressed() -> void:
	$menu_start.show()
	$menu_levels.hide()


func _on_texture_button_pressed3() -> void:
	game.level=2
	game.changeLevel()


func _on_texture_button_pressed4() -> void:
	game.level=3
	game.changeLevel()


func _on_texture_button_pressed5() -> void:
	game.level=4
	game.changeLevel()


func _on_wroc_pressed() -> void:
	$menu_levels.show()
	for child in game_container.get_children():
		child.queue_free()
	$wroc.hide()
	$ruchy.hide()
	

func moves_update():
	$ruchy/liczba_ruchow.text = str(game.moves)

func _on_language_button_item_selected(index: int) -> void:
	if index == 1:
		lang = "polish"
		$menu_levels/Label.text = "Wybierz poziom"
		$Ustawienia/settings_button2.text = "Ustawienia"
		$Ustawienia/contols_button.text = "Sterowanie"
		$Ustawienia/Settings/music_label.text = "Muzyka"
		$Ustawienia/Settings/sfx_label.text = "Efekty dźwiękowe"
		$Ustawienia/Settings/language_label.text = "Język"
		$Ustawienia/Settings/language_button.set_item_text(0, "Angielski")
		$Ustawienia/Settings/language_button.set_item_text(1, "Polski")
		$Ustawienia/close_button.text = "Zamknij"
		$Ustawienia/Controls/up_bind/Label_up_bind.text = "Idź w górę"
		$Ustawienia/Controls/up_bind/up_bind_button.text = "Zmień"
		$Ustawienia/Controls/down_bind/Label_down_bind.text = "Idź w dół"
		$Ustawienia/Controls/down_bind/down_bind_button.text = "Zmień"
		$Ustawienia/Controls/right_bind/Label_right_bind.text = "Idź w prawo"
		$Ustawienia/Controls/right_bind/right_bind_button.text = "Zmień"
		$Ustawienia/Controls/left_bind/Label_left_bind.text = "Idź w lewo"
		$Ustawienia/Controls/left_bind/left_bind_button.text = "Zmień"
		$Ustawienia/Controls/interaction_bind/Label_interaction.text = "Interakcja"
		$Ustawienia/Controls/interaction_bind/interaction_bind_button.text = "Zmień"
		$ruchy.text = "Ruchy: "
		$zwyciestwo/Label.text = "Zwycięstwo"
		$porazka/Label.text = "Koniec ruchów"
	else:
		lang = "english"
		$menu_levels/Label.text = "Choose level"
		$Ustawienia/settings_button2.text = "Settings"
		$Ustawienia/contols_button.text = "Controls"
		$Ustawienia/Settings/music_label.text = "Music"
		$Ustawienia/Settings/sfx_label.text = "Sound effects"
		$Ustawienia/Settings/language_label.text = "Language"
		$Ustawienia/Settings/language_button.set_item_text(0, "English")
		$Ustawienia/Settings/language_button.set_item_text(1, "Polish")
		$Ustawienia/close_button.text = "Close"
		$Ustawienia/Controls/up_bind/Label_up_bind.text = "Move up"
		$Ustawienia/Controls/up_bind/up_bind_button.text = "Change"
		$Ustawienia/Controls/down_bind/Label_down_bind.text = "Move down"
		$Ustawienia/Controls/down_bind/down_bind_button.text = "Change"
		$Ustawienia/Controls/right_bind/Label_right_bind.text = "Move right"
		$Ustawienia/Controls/right_bind/right_bind_button.text = "Change"
		$Ustawienia/Controls/left_bind/Label_left_bind.text = "Move left"
		$Ustawienia/Controls/left_bind/left_bind_button.text = "Change"
		$Ustawienia/Controls/interaction_bind/Label_interaction.text = "Interaction"
		$Ustawienia/Controls/interaction_bind/interaction_bind_button.text = "Change"
		$ruchy.text = "Moves:"
		$zwyciestwo/Label.text = "You won"
		$porazka/Label.text = "Run out of moves"


func _on_texture_button_pressed6() -> void:
	game.level=5
	game.changeLevel()


func _on_texture_button_pressed7() -> void:
	game.level=6
	game.changeLevel()


func _on_texture_button_pressed8() -> void:
	game.level=7
	game.changeLevel()


func _on_texture_button_pressed9() -> void:
	game.level=8
	game.changeLevel()


func _on_texture_button_pressed10() -> void:
	game.level=9
	game.changeLevel()


func koniec(wynik):
	get_node("czas").start()
	if wynik == 1:
		$zwyciestwo.show()
		$menu_levels.hide()
	else: 
		$porazka.show()

func _on_czas_timeout() -> void:
	$zwyciestwo.hide()
	$porazka.hide()
	
func zamknij_poziom():
	for child in game_container.get_children():
		child.queue_free()
