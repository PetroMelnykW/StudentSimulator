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

func _ready():
	await get_tree().create_timer(4).timeout
	_on_data_changed(CodeLearning.instance.available_blocks)
	CodeLearning.instance.data_changed.connect(_on_data_changed)

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

func _on_data_changed(available_blocks: Array):
	for i in range($OptionButton.item_count):
		$OptionButton.set_item_disabled(i, not available_blocks.has(float(i)))
