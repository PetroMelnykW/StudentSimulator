class_name InitVariable
extends PanelContainer

var variable_type
var variable_name: String
var variable_value

var _value_block: Control

func run_block():
	match variable_type:
		"int": variable_value = int(_value_block.get_value())
		"float": variable_value = float(_value_block.get_value())
		"str": variable_value = str(_value_block.get_value())
		"bool": variable_value = _value_block.get_value().to_lower() == "true"

func _input(event):
	if event is InputEventMouseButton and event.button_index == 1:
		if not $MarginContainer/HBoxContainer/HBoxContainer/VarNameEdit.get_rect().has_point(get_local_mouse_position()):
			_check_name()

func _check_name():
	var var_edit_text = $MarginContainer/HBoxContainer/HBoxContainer/VarNameEdit.text.replace(" ", "")
	if var_edit_text != "":
		if var_edit_text[0].is_valid_int():
			var_edit_text = ""
	
	for variable in CodeEditor.instance.variables:
		if var_edit_text == variable.variable_name and self != variable:
			var_edit_text = ""
	
	variable_name = var_edit_text
	$MarginContainer/HBoxContainer/HBoxContainer/VarNameEdit.text = variable_name

func _on_choose_var_type_button_item_selected(index):
	variable_type = $MarginContainer/HBoxContainer/HBoxContainer/ChooseVarTypeButton.get_item_text(index)

func _on_choose_input_button_block_created(block):
	_value_block = block

func _on_delete_block_button_pressed():
	CodeEditor.instance.variables.erase(self)
	CodeEditObserver.instance.variables_array_updated.emit()
	get_parent().remove_child(self)
	queue_free()
