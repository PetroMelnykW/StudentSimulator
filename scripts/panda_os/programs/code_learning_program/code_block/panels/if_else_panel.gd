extends PanelContainer

var _block

@onready var _choose_logic_operator_button = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/ChooseLogicOperatorButton

func run_block():
	var value_1 = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/HBoxContainer.get_children()[1].get_value()
	var value_2 = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/HBoxContainer2.get_children()[1].get_value()
	var logic_operator = _choose_logic_operator_button.get_item_text(_choose_logic_operator_button.selected)
	match typeof(value_1):
		TYPE_INT:
			value_2 = int(value_2)
		TYPE_FLOAT:
			value_2 = float(value_2)
		TYPE_STRING:
			value_2 = str(value_2)
		TYPE_BOOL:
			value_2 = value_2 == "true"
	
	match logic_operator:
		"==":
			if value_1 == value_2:
				_block = $MarginContainer/VBoxContainer/IfBox/HBoxContainer2/VBoxContainer/Blocks
			else:
				_block = $MarginContainer/VBoxContainer/ElseBox/HBoxContainer2/VBoxContainer/Blocks
		"!=":
			if value_1 != value_2:
				_block = $MarginContainer/VBoxContainer/IfBox/HBoxContainer2/VBoxContainer/Blocks
			else:
				_block = $MarginContainer/VBoxContainer/ElseBox/HBoxContainer2/VBoxContainer/Blocks
		"<=":
			if value_1 <= value_2:
				_block = $MarginContainer/VBoxContainer/IfBox/HBoxContainer2/VBoxContainer/Blocks
			else:
				_block = $MarginContainer/VBoxContainer/ElseBox/HBoxContainer2/VBoxContainer/Blocks
		">=":
			if value_1 >= value_2:
				_block = $MarginContainer/VBoxContainer/IfBox/HBoxContainer2/VBoxContainer/Blocks
			else:
				_block = $MarginContainer/VBoxContainer/ElseBox/HBoxContainer2/VBoxContainer/Blocks
		"<":
			if value_1 < value_2:
				_block = $MarginContainer/VBoxContainer/IfBox/HBoxContainer2/VBoxContainer/Blocks
			else:
				_block = $MarginContainer/VBoxContainer/ElseBox/HBoxContainer2/VBoxContainer/Blocks
		">":
			if value_1 > value_2:
				_block = $MarginContainer/VBoxContainer/IfBox/HBoxContainer2/VBoxContainer/Blocks
			else:
				_block = $MarginContainer/VBoxContainer/ElseBox/HBoxContainer2/VBoxContainer/Blocks

func _on_delete_block_button_pressed():
	get_parent().remove_child(self)
	queue_free()
