extends PanelContainer

var _value_block_1
var _value_block_2
var _index

@onready var choose_operator_button = $HBoxContainer/ChooseOperatorButton

func get_value():
	var operator = choose_operator_button.get_item_text(_index)
	var value_1 = float(_value_block_1.get_value())
	var value_2 = float(_value_block_2.get_value())
	match operator:
		"+": return value_1 + value_2
		"-": return value_1 - value_2
		"*": return value_1 * value_2
		"/": return value_1 / value_2

func _on_choose_input_button_block_created(block):
	_value_block_1 = block

func _on_choose_input_button_block_created_2(block):
	_value_block_2 = block

func _on_choose_operator_button_item_selected(index):
	_index = index
