class_name CodeEditor
extends ColorRect

static var instance: CodeEditor

@onready var blocks = $ScrollContainer/MarginContainer/CodeBox/Blocks

var variables: Array[InitVariable]
var functions: Array

func get_variable_by_name(name: String) -> InitVariable:
	for variable: InitVariable in variables:
		if variable.variable_name == name:
			return variable
	
	return null

func code_reader(blocks):
	for block in blocks.get_children():
		if not block is InitFunction:
			block.run_block()

func console_print(text: String):
	$"../VisualCodeBlock/ConsoleLabel".text += "\n" + text

func _ready():
	instance = self

func _on_run_code_button_pressed():
	$"../VisualCodeBlock/ConsoleLabel".text = ""
	code_reader(blocks)
	for variable: InitVariable in variables:
		variable.variable_value = null
