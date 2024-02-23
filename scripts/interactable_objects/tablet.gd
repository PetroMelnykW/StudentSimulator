extends Area3D

func _on_interactable_focused() -> void:
	$"nook wifi 002/nook".set_layer_mask_value(2, true);

func _on_interactable_unfocused() -> void:
	$"nook wifi 002/nook".set_layer_mask_value(2, false);
