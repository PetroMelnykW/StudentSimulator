extends StaticBody3D

func _on_interactable_focused():
	$Mesh/nook.set_layer_mask_value(2, true)

func _on_interactable_unfocused():
	$Mesh/nook.set_layer_mask_value(2, false)

func _on_interactable_interacted(interactor):
	pass # Replace with function body.
