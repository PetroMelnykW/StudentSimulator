class_name ClassroomDoor
extends StaticBody3D

@export_file("*.tscn") var _scene_to_load : String

func _on_interactable_interacted(_interactor: Player) -> void:
	var main_scene: Main = get_tree().current_scene
	main_scene.change_room(_scene_to_load)
