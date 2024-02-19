extends PanelContainer

@export_file("*.tscn") var init_var_panel_scene
@export_file("*.tscn") var if_panel_scene
@export_file("*.tscn") var if_else_panel_scene
@export_file("*.tscn") var while_panel_scene
@export_file("*.tscn") var for_panel_scene
@export_file("*.tscn") var init_function_panel_scene
@export_file("*.tscn") var print_panel_scene
@export_file("*.tscn") var call_function_panel_scene
@export_file("*.tscn") var reassignment_var_panel_scene

func _on_option_button_item_selected(index):
	var add_block: Control
	match index:
		0:
			add_block = load(init_var_panel_scene).instantiate()
			CodeEditor.instance.variables.append(add_block)
		1:
			add_block = load(if_panel_scene).instantiate()
		2:
			add_block = load(if_else_panel_scene).instantiate()
		3:
			add_block = load(while_panel_scene).instantiate()
		4:
			add_block = load(for_panel_scene).instantiate()
		5:
			add_block = load(init_function_panel_scene).instantiate()
			CodeEditor.instance.functions.append(add_block)
		6:
			add_block = load(print_panel_scene).instantiate()
		7:
			add_block = load(call_function_panel_scene).instantiate()
		8:
			add_block = load(reassignment_var_panel_scene).instantiate()
	
	$"../Blocks".add_child(add_block)
	$OptionButton.selected = -1
