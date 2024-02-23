extends PanelContainer

func run_block():
	for function: InitFunction in CodeEditor.instance.functions:
		if function.function_name == $MarginContainer/HBoxContainer/HBoxContainer/ChooseFunctionButton.text:
			CodeEditor.instance.code_reader(function.blocks)

func _on_delete_block_button_pressed():
	get_parent().remove_child(self)
	queue_free()
