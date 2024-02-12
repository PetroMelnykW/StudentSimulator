extends StaticBody3D

@onready var _board_mesh = $"BoardModel/Sketchfab_model/3e25169cc08846c49f54f0df7854d830_fbx/RootNode/Plane_001/Plane_001_whiteboard_0"

func _on_interactable_focused() -> void:
	_board_mesh.set_layer_mask_value(2, true)

func _on_interactable_unfocused() -> void:
	_board_mesh.set_layer_mask_value(2, false)
