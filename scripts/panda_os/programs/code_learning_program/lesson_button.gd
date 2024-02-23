extends Button

var module_number: String
var lesson_number: String
var main_script: Control

func _on_pressed():
	main_script.module_number = module_number
	main_script.lesson_number = lesson_number
	main_script.apply_lesson_data()
