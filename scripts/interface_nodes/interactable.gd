class_name Interactable
extends Node

signal focused
signal unfocused
signal interacted()

@export_category("ObjectInfo")
@export var is_can_interacted : bool = true
@export var is_show_name_info : bool = true
@export var is_show_description_info : bool = true
@export var object_name : String = ""
@export_multiline var object_description : String = ""

func focus() -> void:
	focused.emit()

func unfocus() -> void:
	unfocused.emit()

func interact() -> void:
	if is_can_interacted:
		interacted.emit()
