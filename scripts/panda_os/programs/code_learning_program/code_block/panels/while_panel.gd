extends PanelContainer

@onready var _blocks = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Blocks
@onready var _choose_logic_operator_button = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/ChooseLogicOperatorButton

func run_block():
	var value_1 = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/HBoxContainer.get_children()[1].get_value()
	var value_2 = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/HBoxContainer2.get_children()[1].get_value()
	var logic_operator = _choose_logic_operator_button.get_item_text(_choose_logic_operator_button.selected)
	value_2 = _check_type_value(value_1, value_2)
	match logic_operator:
		"==":
			while value_1 == value_2:
				CodeEditor.instance.code_reader(_blocks)
				value_1 = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/HBoxContainer.get_children()[1].get_value()
				value_2 = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/HBoxContainer2.get_children()[1].get_value()
				value_2 = _check_type_value(value_1, value_2)
		"!=":
			while value_1 != value_2:
				CodeEditor.instance.code_reader(_blocks)
				value_1 = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/HBoxContainer.get_children()[1].get_value()
				value_2 = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/HBoxContainer2.get_children()[1].get_value()
				value_2 = _check_type_value(value_1, value_2)
		"<=":
			while value_1 <= value_2:
				CodeEditor.instance.code_reader(_blocks)
				value_1 = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/HBoxContainer.get_children()[1].get_value()
				value_2 = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/HBoxContainer2.get_children()[1].get_value()
				value_2 = _check_type_value(value_1, value_2)
		">=":
			while value_1 >= value_2:
				CodeEditor.instance.code_reader(_blocks)
				value_1 = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/HBoxContainer.get_children()[1].get_value()
				value_2 = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/HBoxContainer2.get_children()[1].get_value()
				value_2 = _check_type_value(value_1, value_2)
		"<":
			while value_1 < value_2:
				CodeEditor.instance.code_reader(_blocks)
				value_1 = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/HBoxContainer.get_children()[1].get_value()
				value_2 = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/HBoxContainer2.get_children()[1].get_value()
				value_2 = _check_type_value(value_1, value_2)
		">":
			while value_1 > value_2:
				CodeEditor.instance.code_reader(_blocks)
				value_1 = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/HBoxContainer.get_children()[1].get_value()
				value_2 = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/HBoxContainer2.get_children()[1].get_value()
				value_2 = _check_type_value(value_1, value_2)

func _check_type_value(value_1, value_2):
	match typeof(value_1):
		TYPE_INT:
			value_2 = int(value_2)
		TYPE_FLOAT:
			value_2 = float(value_2)
		TYPE_STRING:
			value_2 = str(value_2)
		TYPE_BOOL:
			value_2 = value_2 == "true"
	
	return value_2

func _on_delete_block_button_pressed():
	get_parent().remove_child(self)
	queue_free()
