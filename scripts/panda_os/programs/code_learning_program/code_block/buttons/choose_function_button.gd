extends OptionButton

var _last_choose_item

func get_value():
	for function: InitFunction in CodeEditor.instance.functions:
		if function.function_name == get_item_text(selected):
			CodeEditor.instance.code_reader(function.blocks)
			return function.returt_value.get_child(2).get_value()

func _ready():
	CodeEditObserver.instance.functions_array_updated.connect(_on_function_array_updated)
	_on_function_array_updated()

func _on_function_array_updated():
	_last_choose_item = get_item_text(selected)
	clear()
	for index in range(len(CodeEditor.instance.functions)):
		add_item(CodeEditor.instance.functions[index].function_name, index)
	
	for i in range(item_count):
		if _last_choose_item == get_item_text(i):
			selected = i
		else:
			selected = -1

func _on_pressed():
	_on_function_array_updated()
