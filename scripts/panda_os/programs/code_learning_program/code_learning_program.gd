extends Control

var module_number = "1"
var lesson_number = "1"

var _data: Dictionary
var _data_file_path: String = "res://databases/bamboo+/modules.json"

var _module_name_label = preload("res://scenes/ui/panda_os/programs/code_learning_program/levels_block/module_name_label.tscn")
var _lesson_button = preload("res://scenes/ui/panda_os/programs/code_learning_program/levels_block/lesson_button.tscn")
var _image_box = preload("res://scenes/ui/panda_os/programs/code_learning_program/theoretical_block/image_box.tscn")
var _text_label = preload("res://scenes/ui/panda_os/programs/code_learning_program/theoretical_block/text_label.tscn")

func apply_lesson_data():
	var lesson: Dictionary = _data[module_number]["lessons"][lesson_number]
	$TopBar/ModuleName.text = _data[module_number]["name"]
	$TopBar/ShowLevelsBlockButton/LessonName.text = lesson["name"]
	$TopBar/ShowLevelsBlockButton/LessonNumber.text = "Module %s / Lesson %s" % [module_number, lesson_number]
	
	if $TheoreticalBlock/ScrollContainer/VBoxContainer.get_child_count() != 0:
		for child in $TheoreticalBlock/ScrollContainer/VBoxContainer.get_children():
			child.queue_free()
			$TheoreticalBlock/ScrollContainer/VBoxContainer.remove_child(child)
	
	for el in lesson["theoretical_text"]:
		if el.substr(0, 6) == "res://":
			_create_text_label(el)
		else:
			_create_image_box(el)
			
	_check_lesson_buttons()

func _ready():
	_data = _load_data_data(_data_file_path)
	
	for module in _data:
		_create_module_label(module)
		for lesson in _data[module]["lessons"]:
			_create_lesson_button(module, lesson)
	
	apply_lesson_data()

func _create_module_label(module):
	var label = _module_name_label.instantiate()
	$LevelsBlock/ScrollContainer/VBoxContainer.add_child(label)
	label.text = "%s: %s" % [module, _data[module]["name"]]

func _create_lesson_button(module, lesson):
	var button = _lesson_button.instantiate()
	$LevelsBlock/ScrollContainer/VBoxContainer.add_child(button)
	button.module_number = module
	button.lesson_number = lesson
	button.main_script = self
	button.text = "%s: %s" % [lesson, _data[module]["lessons"][lesson]["name"]]

func _create_text_label(el: String):
	var image_box = _image_box.instantiate()
	$TheoreticalBlock/ScrollContainer/VBoxContainer.add_child(image_box)
	image_box.get_child(0).texture = load(el)

func _create_image_box(el: String):
	var text_label = _text_label.instantiate()
	$TheoreticalBlock/ScrollContainer/VBoxContainer.add_child(text_label)
	text_label.text = el

func _load_data_data(file_path: String):
	if FileAccess.file_exists(file_path):
		var data_file = FileAccess.open(file_path, FileAccess.READ)
		var parce_result = JSON.parse_string(data_file.get_as_text())
		
		if parce_result is Dictionary:
			return parce_result
		else:
			print("Error reading file")
	else:
		print("File doesn't exist")

func _str_add(a: String, b: int):
	return str(int(a) + b)

func _str_sub(a: String, b: int):
	return str(int(a) - b)

func _check_lesson_buttons():
	$TopBar/LastLessonButton.disabled = module_number == "1" and lesson_number == "1"
	$TopBar/NextLessonButton.disabled = module_number == _data.keys()[-1] and lesson_number == _data[module_number]["lessons"].keys()[-1]

func _on_show_theoretical_block_button_toggled(toggled_on):
	$TheoreticalBlock/ShowTheoreticalBlockButton.text = "<" if toggled_on else ">"
	$TheoreticalBlock/AnimationPlayer.play("show" if toggled_on else "hide")

func _on_show_levels_block_toggled(toggled_on):
	$LevelsBlock/AnimationPlayer.play("show" if toggled_on else "hide")

func _on_last_lesson_button_pressed():
	lesson_number = _str_sub(lesson_number, 1)
	if _data[module_number]["lessons"].has(lesson_number):
		apply_lesson_data()
	else:
		module_number = _str_sub(module_number, 1)
		lesson_number = _data[module_number]["lessons"].keys()[-1]
		apply_lesson_data()

func _on_next_lesson_button_pressed():
	lesson_number = _str_add(lesson_number, 1)
	if _data[module_number]["lessons"].has(lesson_number):
		apply_lesson_data()
	else:
		module_number = _str_add(module_number, 1)
		lesson_number = "1"
		apply_lesson_data()
