class_name ClassroomDoor
extends StaticBody3D

@export_file("*.tscn") var _scene_to_load : String

<<<<<<< HEAD
func _on_interactable_interacted(_interactor: Player) -> void:
	var main_scene: Main = get_tree().current_scene
=======
@onready var _doorMesh : MeshInstance3D = $"DoorModel/10057_wooden_door_v002"
@onready var _doorFrame : MeshInstance3D = $"DoorModel/10057_wooden_door_frame_v002"

func _on_interactable_focused() -> void:
	_doorMesh.set_layer_mask_value(2, true)
	_doorFrame.set_layer_mask_value(2, true)

func _on_interactable_unfocused() -> void:
	_doorMesh.set_layer_mask_value(2, false)
	_doorFrame.set_layer_mask_value(2, false)

func _on_interactable_interacted(interactor : Player) -> void:
	var main_scene : Main = get_tree().current_scene
>>>>>>> 6b565eec1fd2cdc3e7912b4fbe92011cde837926
	main_scene.change_room(_scene_to_load)
