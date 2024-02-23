extends PanelContainer

@onready var _blocks = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Blocks

func run_block():
	var number = int($MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/HBoxContainer.get_children()[1].get_value())
	for i in range(number):
		CodeEditor.instance.code_reader(_blocks)

func _on_delete_block_button_pressed():
	get_parent().remove_child(self)
	queue_free()
