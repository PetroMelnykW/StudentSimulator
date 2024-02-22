class_name CodeEditObserver
extends Node

signal variables_array_updated
signal functions_array_updated

static var instance: CodeEditObserver

func _ready():
	instance = self
