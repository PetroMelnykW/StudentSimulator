extends Area3D

@onready var _motherboard_camera = $Camera3D

func _on_interactable_focused():
	$OutlineModel/Battery.set_layer_mask_value(3, true)

func _on_interactable_unfocused():
	$OutlineModel/Battery.set_layer_mask_value(3, false)

func _on_interactable_interacted():
	CameraController.transit_camera_3d(_motherboard_camera)
