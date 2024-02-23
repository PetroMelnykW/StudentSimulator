extends OptionButton

signal block_created(block)

@export_file("*.tscn") var _write_value_edit_scene
@export_file("*.tscn") var _choose_var_button_scene
@export_file("*.tscn") var _expression_panel_scene
@export_file("*.tscn") var _choose_function_button_scene
@export_file("*.tscn") var _go_to_choose_button_scene

func _on_item_selected(index):
	var go_to_choose_button = load(_go_to_choose_button_scene).instantiate()
	var block
	match index:
		0:
			block = load(_write_value_edit_scene).instantiate()
		1:
			block = load(_choose_var_button_scene).instantiate()
		2:
			block = load(_expression_panel_scene).instantiate()
		3:
			block = load(_choose_function_button_scene).instantiate()
	
	block_created.emit(block)
	get_parent().add_child(block)
	get_parent().add_child(go_to_choose_button)
	visible = false
