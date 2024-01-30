class_name ClassroomDoor
extends StaticBody3D

@export_file("*.tscn") var _scene_to_load : String

@onready var _mesh_instance = $MeshInstance3D

func _on_interactable_focused() -> void:
	_mesh_instance.mesh.surface_get_material(0).next_pass.set_shader_parameter("enable", true)

func _on_interactable_unfocused() -> void:
	_mesh_instance.mesh.surface_get_material(0).next_pass.set_shader_parameter("enable", false)

func _on_interactable_interacted(interactor : Player) -> void:
	var main_scene : Main = get_tree().current_scene
	main_scene.change_room(_scene_to_load)
