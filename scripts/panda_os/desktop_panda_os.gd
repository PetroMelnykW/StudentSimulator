extends Control

func _on_close_settings_button_pressed():
	$CenterContainer.hide()

func _on_settings_button_pressed():
	$CenterContainer.show()
	$Background/DownPanel/StartMenu.hide()

func _on_backgroung_1_button_pressed():
	$Background.texture = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Backgroung1Button.icon

func _on_backgroung_2_button_pressed():
	$Background.texture = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Backgroung2Button.icon

func _on_color_picker_button_color_changed(color):
	$Background/DownPanel.color = color
	color.v = color.v * 0.7
	$Background/DownPanel/StartMenu.color = color
