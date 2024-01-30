extends ColorRect

func _process(delta):
	var time = Time.get_datetime_dict_from_system()
	$Clock/Time.text = "%02d:%02d" % [time.hour, time.minute]
	$Clock/Date.text = "%02d/%02d/%02d" % [time.day, time.month, time.year]

func _on_start_button_toggled(toggled_on):
	$StartMenu.visible = toggled_on
