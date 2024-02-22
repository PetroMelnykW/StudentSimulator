class_name LocalVariable
extends HBoxContainer

var local_variable_type: String
var local_variable_name: String
var local_variable_value

var _local_variables = self

func _ready():
	while true:
		_local_variables = _local_variables.get_parent()
		if _local_variables is InitFunction:
			break

func _on_choose_local_var_type_button_item_selected(index):
	local_variable_type = $ChooseLocalVarTypeButton.get_item_text(index)

func _input(event):
	if event is InputEventMouseButton and event.button_index == 1:
		if not $LocalVarNameEdit.get_rect().has_point(get_local_mouse_position()):
			_check_name()

func _check_name():
	var var_edit_text = $LocalVarNameEdit.text.replace(" ", "")
	if var_edit_text != "":
		if var_edit_text[0].is_valid_int():
			var_edit_text = ""
	
	for local_variable in _local_variables.function_local_variables:
		if var_edit_text == local_variable.local_variable_name and self != local_variable:
			var_edit_text = ""
	
	for variable in CodeEditor.instance.variables:
		if var_edit_text == variable.variable_name and self != variable:
			var_edit_text = ""
	
	local_variable_name = var_edit_text
	$LocalVarNameEdit.text = local_variable_name

func _on_delete_local_var_button_pressed():
	_local_variables.function_local_variables.erase(self)
	get_parent().remove_child(self)
	queue_free()
