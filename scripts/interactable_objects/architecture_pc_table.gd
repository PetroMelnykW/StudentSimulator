extends StaticBody3D

@onready var _architecture_camera : Camera3D = $Camera3D
@onready var _computer_architecture_game_ui : CanvasLayer = $ComputerArchitectureGameUI

func _on_table_focused() -> void:
	$"CofeeTableModel/Coffee table".set_layer_mask_value(2, true);
	$PCCaseModel/CorsairCase/Kasa.set_layer_mask_value(2, true);

func _on_table_unfocused() -> void:
	$"CofeeTableModel/Coffee table".set_layer_mask_value(2, false);
	$PCCaseModel/CorsairCase/Kasa.set_layer_mask_value(2, false);

func _on_table_interacted(_interactor : Player) -> void:
	_start_computer_architecture_game()

func _start_computer_architecture_game() -> void:
	_on_table_unfocused()
	await CameraController.transit_camera_3d(_architecture_camera)
	_computer_architecture_game_ui.visible = true
