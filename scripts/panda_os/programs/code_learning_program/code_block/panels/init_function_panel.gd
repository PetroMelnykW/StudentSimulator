class_name InitFunction
extends PanelContainer

@export_file("*.tscn") var choose_input_button_scene

var function_name

@onready var returt_value = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Return
@onready var blocks = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Blocks

func _input(event):
	if event is InputEventMouseButton and event.button_index == 1:
		if not $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/FunctionNameEdit.get_rect().has_point(get_local_mouse_position()):
			_check_name()

func _check_name():
	var function_edit_text = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/FunctionNameEdit.text.replace(" ", "")
	if function_edit_text != "":
		if function_edit_text[0].is_valid_int():
			function_edit_text = ""
	
	for function in CodeEditor.instance.functions:
		if function_edit_text == function.function_name and self != function:
			function_edit_text = ""
	
	function_name = function_edit_text
	$MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/FunctionNameEdit.text = function_name

func _on_delete_block_button_pressed():
	CodeEditor.instance.functions.erase(self)
	CodeEditObserver.instance.functions_array_updated.emit()
	get_parent().remove_child(self)
	queue_free()

func _on_add_arguments_button_pressed():
	var choose_input_button = load(choose_input_button_scene).instantiate()
	var new_hbox = HBoxContainer.new()
	$MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/Arguments.add_child(new_hbox)
	$MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/Arguments.get_children()[-1].add_child(choose_input_button)
