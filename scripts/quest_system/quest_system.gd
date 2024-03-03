class_name QuestSystem
extends CanvasLayer

static var instance: QuestSystem

@export_file("*.json") var _data_file

var _data: Dictionary
var _current_answer: String = ""
var _correct_answer: String = ""
var _answers_button_group: ButtonGroup
var _current_tablet: Tablet
var _is_ready_to_quest: bool = true

var COLLECTION_ID = 'player_stats'
var collection: FirestoreCollection
var auth = Firebase.Auth.auth
var scoreForAnswer = 20
#dependencies
@onready var _answer_panel_animator: AnimationPlayer = $SubminControl/CenterContainer/AnimationPlayer
#ui
@onready var _main_node: Control = $Control
@onready var _answers_container: Control = $Control/CenterContainer/Tablet/CenterContainer/MarginContainer/VBoxContainer/AnswersVBoxContainer
@onready var _question_label: Label = $Control/CenterContainer/Tablet/CenterContainer/MarginContainer/VBoxContainer/QuestionContantLabel
@onready var _answer_1_check_box: CheckBox = $Control/CenterContainer/Tablet/CenterContainer/MarginContainer/VBoxContainer/AnswersVBoxContainer/Answer1CheckBox
@onready var _answer_2_check_box: CheckBox = $Control/CenterContainer/Tablet/CenterContainer/MarginContainer/VBoxContainer/AnswersVBoxContainer/Answer2CheckBox
@onready var _answer_3_check_box: CheckBox = $Control/CenterContainer/Tablet/CenterContainer/MarginContainer/VBoxContainer/AnswersVBoxContainer/Answer3CheckBox
@onready var _answer_4_check_box: CheckBox = $Control/CenterContainer/Tablet/CenterContainer/MarginContainer/VBoxContainer/AnswersVBoxContainer/Answer4CheckBox
@onready var _correct_panel: Panel = $SubminControl/CenterContainer/CorrectSubmitPanel
@onready var _incorrect_panel: Panel = $SubminControl/CenterContainer/IncorrectSubmitPanel

func apply_answer_data(tablet: Tablet) -> void:
	if not _is_ready_to_quest: return
	PlayerState.change_mode(PlayerState.GameMode.QUEST)
	_main_node.show()
	_current_tablet = tablet
	if _data.has(tablet.question_key):
		var question: Dictionary = _data[tablet.question_key]
		_question_label.text = question["question"]
		_answer_1_check_box.text = question["answers"][0]
		_answer_2_check_box.text = question["answers"][1]
		_answer_3_check_box.text = question["answers"][2]
		_answer_4_check_box.text = question["answers"][3]
		_correct_answer = question["correct_answer"]
	else:
		_question_label.text = "Is this question loaded?"
		_answer_1_check_box.text = "No"
		_answer_2_check_box.text = "No"
		_answer_3_check_box.text = "No"
		_answer_4_check_box.text = "No"
		_correct_answer = "Yes"

func _init() -> void: 
	instance = self

func _ready() -> void:
	_answers_button_group = $Control/CenterContainer/Tablet/CenterContainer/MarginContainer/VBoxContainer/AnswersVBoxContainer/Answer1CheckBox.button_group
	_data = _load_data()

func _load_data():
	if FileAccess.file_exists(_data_file):
		var data_file = FileAccess.open(_data_file, FileAccess.READ)
		var parce_result = JSON.parse_string(data_file.get_as_text())
		
		if parce_result is Dictionary:
			return parce_result
		else:
			printerr("Error reading file")
	else:
		printerr("File doesn't exist")

func _on_exit_button_pressed() -> void:
	_main_node.hide()
	_current_tablet = null
	_current_answer = ""
	_correct_answer = ""
	var pressed_button: CheckBox = _answers_button_group.get_pressed_button()
	if pressed_button: pressed_button.button_pressed = false
	PlayerState.change_mode(PlayerState.GameMode.WALK)

func _on_submit_button_pressed() -> void:
	if _current_answer == "": return
	
	_is_ready_to_quest = false
	_current_tablet.get_parent().remove_child(_current_tablet)
	_current_tablet.queue_free()
	var _answer_panel: Panel
	if _current_answer == _correct_answer:
		set_score()
		_answer_panel = _correct_panel
		_answer_panel.show()
		_answer_panel_animator.play("correct_hide")
	else:
		_answer_panel = _incorrect_panel
		_answer_panel.show()
		_answer_panel_animator.play("incorrect_hide")
	_on_exit_button_pressed()
	await _answer_panel_animator.animation_finished
	_answer_panel.hide()
	_is_ready_to_quest = true

func _on_answer_check_box_pressed() -> void:
	_current_answer = _answers_button_group.get_pressed_button().text

func set_score():
	collection = Firebase.Firestore.collection(COLLECTION_ID)
	var task = collection.get_doc(auth.localid)
	var result = await task.get_document
	print(result['doc_fields']['score'])
	var score = result['doc_fields']['score']
	var data: Dictionary = {
		'score': score + scoreForAnswer
	}
	var task2: FirestoreTask = collection.update(auth.localid, data)
