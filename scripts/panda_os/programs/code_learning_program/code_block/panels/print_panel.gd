extends PanelContainer

func run_block():
	var result = $MarginContainer/HBoxContainer/HBoxContainer/Result.get_child(1).get_value()
	CodeEditor.instance.console_print(str(result))

func _on_delete_block_button_pressed():
	get_parent().remove_child(self)
	queue_free()
