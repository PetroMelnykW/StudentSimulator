extends PanelContainer

@onready var _choose_var_button = $MarginContainer/HBoxContainer/HBoxContainer/ChooseVarButton

func run_block():
	var new_value = $MarginContainer/HBoxContainer/HBoxContainer/HBoxContainer.get_children()[1]
	for variable in CodeEditor.instance.variables:
		if variable.variable_name == _choose_var_button.get_item_text(_choose_var_button.selected):
			match variable.variable_type:
				"int": variable.variable_value = int(new_value.get_value())
				"float": variable.variable_value = float(new_value.get_value())
				"str": variable.variable_value = str(new_value.get_value())
				"bool": variable.variable_value = new_value.get_value().to_lower() == "true"

func _on_delete_block_button_pressed():
	get_parent().remove_child(self)
	queue_free()
