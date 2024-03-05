class_name CodeLearning
extends Control

signal data_changed(available_blocks: Array)

static var instance: CodeLearning

const COLLECTION_ID = "player_stats"
var scoreForAnswer = 60
var module_number = "1"
var lesson_number = "1"
var available_blocks: Array

var _data: Dictionary
var _data_file_path: String = "res://databases/bamboo+/modules.json"
var _server_player_data: Dictionary

var _module_name_label = preload("res://scenes/ui/panda_os/programs/code_learning_program/levels_block/module_name_label.tscn")
var _lesson_button = preload("res://scenes/ui/panda_os/programs/code_learning_program/levels_block/lesson_button.tscn")
var _image_box = preload("res://scenes/ui/panda_os/programs/code_learning_program/theoretical_block/image_box.tscn")
var _text_label = preload("res://scenes/ui/panda_os/programs/code_learning_program/theoretical_block/text_label.tscn")

func apply_lesson_data():
	_remove_code()
	$VisualCodeBlock/ScrollContainer/MarginContainer/ConsoleLabel.text = ""
	available_blocks = _data[module_number]["lessons"][lesson_number]["available_blocks"]
	data_changed.emit(available_blocks)
	var lesson: Dictionary = _data[module_number]["lessons"][lesson_number]
	$TopBar/ModuleName.text = _data[module_number]["name"]
	$TopBar/ShowLevelsBlockButton/LessonName.text = lesson["name"]
	$TopBar/ShowLevelsBlockButton/LessonNumber.text = "Module %s / Lesson %s" % [module_number, lesson_number]
	
	if $TheoreticalBlock/ScrollContainer/MarginContainer/VBoxContainer.get_child_count() != 0:
		for child in $TheoreticalBlock/ScrollContainer/MarginContainer/VBoxContainer.get_children():
			child.queue_free()
			$TheoreticalBlock/ScrollContainer/MarginContainer/VBoxContainer.remove_child(child)
	
	for el in lesson["theoretical_text"]:
		if el.substr(0, 6) == "res://":
			_create_text_label(el)
		else:
			_create_image_box(el)
	
	_check_lesson_buttons()

func check_task_result():
	if _data[module_number]["lessons"][lesson_number]["console_result"] == $VisualCodeBlock/ScrollContainer/MarginContainer/ConsoleLabel.text:
		var unlock_module_number = _str_add(module_number, 1) if (module_number != _data.keys()[-1] and lesson_number == _data[module_number]["lessons"].keys()[-1]) else module_number
		var unlock_lesson_number = _str_add(lesson_number, 1) if (lesson_number != _data[module_number]["lessons"].keys()[-1]) else "1"
		var auth = Firebase.Auth.auth
		set_score()
		if auth.localid:
			var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
			var data: Dictionary = _server_player_data
			if not unlock_lesson_number in data["available_lessons"][unlock_module_number]:
				data["available_lessons"][unlock_module_number].append(unlock_lesson_number)
				var task: FirestoreTask = collection.update(auth.localid, data)
				_load_server_player_data()
				_check_lesson_buttons()
				_update_levels_block()

func _ready():
	instance = self
	_data = _load_data_data(_data_file_path)
	await _load_server_player_data()
	
	_update_levels_block()
	apply_lesson_data()

func _create_module_label(module):
	var label = _module_name_label.instantiate()
	$LevelsBlock/ScrollContainer/MarginContainer/VBoxContainer.add_child(label)
	label.text = "%s: %s" % [module, _data[module]["name"]]

func _create_lesson_button(module, lesson):
	var button = _lesson_button.instantiate()
	$LevelsBlock/ScrollContainer/MarginContainer/VBoxContainer.add_child(button)
	button.module_number = module
	button.lesson_number = lesson
	button.main_script = self
	button.text = "%s: %s" % [lesson, _data[module]["lessons"][lesson]["name"]]
	if module in _server_player_data["available_lessons"]:
		if not lesson in _server_player_data["available_lessons"][module]:
			button.disabled = true
	else:
		button.disabled = true

func _create_text_label(el: String):
	var image_box = _image_box.instantiate()
	$TheoreticalBlock/ScrollContainer/MarginContainer/VBoxContainer.add_child(image_box)
	image_box.get_child(0).texture = load(el)

func _create_image_box(el: String):
	var text_label = _text_label.instantiate()
	$TheoreticalBlock/ScrollContainer/MarginContainer/VBoxContainer.add_child(text_label)
	text_label.text = el

func _remove_code():
	for child in $CodeBlock/ScrollContainer/MarginContainer/CodeBox/Blocks.get_children():
		CodeEditor.instance.variables.clear()
		CodeEditor.instance.functions.clear()
		$CodeBlock/ScrollContainer/MarginContainer/CodeBox/Blocks.remove_child(child)
		child.queue_free()

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

func _load_server_player_data():
	var auth = Firebase.Auth.auth
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		var task = collection.get_doc(auth.localid)
		var result = await task.get_document
		_server_player_data = result["doc_fields"]

func _str_add(a: String, b: int):
	return str(int(a) + b)

func _str_sub(a: String, b: int):
	return str(int(a) - b)

func _check_lesson_buttons():
	$TopBar/LastLessonButton.disabled = module_number == "1" and lesson_number == "1"
	var next_module_number
	var next_lesson_number
	if lesson_number == _data[module_number]["lessons"].keys()[-1] and module_number != _data.keys()[-1]:
		next_module_number = _str_add(module_number, 1)
		next_lesson_number = "1"
	else:
		next_module_number = module_number
		next_lesson_number = _str_add(lesson_number, 1)
	$TopBar/NextLessonButton.disabled = (module_number == _data.keys()[-1]
										and lesson_number == _data[module_number]["lessons"].keys()[-1]
										or not next_lesson_number in _server_player_data["available_lessons"][next_module_number])

func _update_levels_block():
	for child in $LevelsBlock/ScrollContainer/MarginContainer/VBoxContainer.get_children():
		$LevelsBlock/ScrollContainer/MarginContainer/VBoxContainer.remove_child(child)
		child.queue_free()
	
	for module in _data:
		_create_module_label(module)
		for lesson in _data[module]["lessons"]:
			_create_lesson_button(module, lesson)

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

func _on_quit_button_pressed():
	visible = false

func set_score():
	var collection: FirestoreCollection
	var auth = Firebase.Auth.auth
	collection = Firebase.Firestore.collection(COLLECTION_ID)
	var task = collection.get_doc(auth.localid)
	var result = await task.get_document
	var score = result['doc_fields']['score']
	var data: Dictionary = {
		result['doc_fields']['name']: score + scoreForAnswer
	}
	var collection2: FirestoreCollection = Firebase.Firestore.collection("leaderboard")
	var task2: FirestoreTask = collection2.update("rating", data)
	var task3: FirestoreTask = collection.update(auth.localid, {"score" : score + scoreForAnswer})
