extends OptionButton

var _last_choose_item

func get_value():
	var variable_name = get_item_text(selected)
	return CodeEditor.instance.get_variable_by_name(variable_name).variable_value

func _ready():
	CodeEditObserver.instance.variables_array_updated.connect(_on_variables_array_updated)
	_on_variables_array_updated()

func _on_variables_array_updated():
	_last_choose_item = get_item_text(selected)
	clear()
	for index in range(len(CodeEditor.instance.variables)):
		add_item(CodeEditor.instance.variables[index].variable_name, index)
	
	for i in range(item_count):
		if _last_choose_item == get_item_text(i):
			selected = i
		else:
			selected = -1

func _on_pressed():
	_on_variables_array_updated()
