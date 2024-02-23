extends Area3D

@onready var _motherboard_camera = $MotherboardCamera
@onready var _interacable: Interactable = $Interactable

var interact_visible: bool = true

func _on_interactable_focused():
	if _interacable.is_can_interacted:
		$OutlineModel/Battery.set_layer_mask_value(3, true)

func _on_interactable_unfocused():
	if _interacable.is_can_interacted:
		$OutlineModel/Battery.set_layer_mask_value(3, false)

func _on_interactable_interacted():
	_on_interactable_focused()
	_interacable.is_can_interacted = false
	await CameraController.transit_camera_3d(_motherboard_camera)
	$ChooseMotherboardUI.show()
