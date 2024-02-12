extends Node3D

@export var _monitor_meshes : Array[MeshInstance3D] = []
@export var _pc_meshes : Array[MeshInstance3D] = []

var _is_pc_turn_on : bool = false

func _on_pc_interacted(interactor : Player) -> void:
	_is_pc_turn_on = not _is_pc_turn_on
	$Monitor/MonitorModel/BlackScreen.visible = not _is_pc_turn_on
	$Monitor/MonitorModel/WhiteScreen.visible = _is_pc_turn_on

func _on_monitor_interacted(interactor : Player) -> void:
	if _is_pc_turn_on:
		_show_os(interactor)

func _show_os(interactor : Player) -> void:
	var main : Main = get_tree().current_scene
	main.switch_os(true)

func _on_monitor_focused() -> void:
	for mesh : MeshInstance3D in _monitor_meshes:
		mesh.set_layer_mask_value(2, true);

func _on_monitor_unfocused() -> void:
	for mesh : MeshInstance3D in _monitor_meshes:
		mesh.set_layer_mask_value(2, false);

func _on_pc_focused() -> void:
	for mesh : MeshInstance3D in _pc_meshes:
		mesh.set_layer_mask_value(2, true);

func _on_pc_unfocused() -> void:
	for mesh : MeshInstance3D in _pc_meshes:
		mesh.set_layer_mask_value(2, false);
