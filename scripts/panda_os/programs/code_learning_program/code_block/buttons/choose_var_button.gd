extends OptionButton

var _last_choose_item
var _local_variables = self

func get_value():
	var variable_name = ""
	if item_count > 0:
		variable_name = get_item_text(selected)
	if variable_name == "":
		return ""
	return CodeEditor.instance.get_variable_by_name(variable_name).variable_value

func _ready():
	CodeEditObserver.instance.variables_array_updated.connect(_on_variables_array_updated)
	while true:
		_local_variables = _local_variables.get_parent()
		if _local_variables is InitFunction or _local_variables == null:
			break
	
	_on_variables_array_updated()

func _on_variables_array_updated():
	_last_choose_item = get_item_text(selected)
	clear()
	for index in range(len(CodeEditor.instance.variables)):
		add_item(CodeEditor.instance.variables[index].variable_name, index)
	
	if _local_variables != null:
		print(_local_variables)
		for index in range(len(_local_variables.function_local_variables)):
			add_item(_local_variables.function_local_variables[index].local_variable_name, index)
	
	for i in range(item_count):
		if _last_choose_item == get_item_text(i):
			selected = i
		else:
			selected = -1

func _on_pressed():
	_on_variables_array_updated()
