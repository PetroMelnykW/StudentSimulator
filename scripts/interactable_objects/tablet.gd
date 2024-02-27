class_name Tablet
extends Area3D

@export var question_key: String

func _on_interactable_focused() -> void:
	$"nook wifi 002/nook".set_layer_mask_value(2, true);

func _on_interactable_unfocused() -> void:
	$"nook wifi 002/nook".set_layer_mask_value(2, false);

func _on_interactable_interacted(interactor: Player) -> void:
	QuestSystem.instance.apply_answer_data(self)
