extends StaticBody3D

@onready var _architecture_core: ArchitectureCore = $ArchitectureCore
@onready var _architecture_camera: Camera3D = $Camera3D

#ui
@onready var _computer_architecture_game_ui: CanvasLayer = $ComputerArchitectureGameUI
@onready var _architecture_core_ui: CanvasLayer = $ArchitectureCore/PCBuildingCanvas

func _on_table_focused() -> void:
	$"CofeeTableModel/Coffee table".set_layer_mask_value(2, true);
	$PCCaseModel/CorsairCase/Kasa.set_layer_mask_value(2, true);

func _on_table_unfocused() -> void:
	$"CofeeTableModel/Coffee table".set_layer_mask_value(2, false);
	$PCCaseModel/CorsairCase/Kasa.set_layer_mask_value(2, false);

func _on_table_interacted() -> void:
	_start_computer_architecture_game()

func _start_computer_architecture_game() -> void:
	_on_table_unfocused()
	await CameraController.transit_camera_3d(_architecture_camera)
	_computer_architecture_game_ui.visible = true

func _on_exit_button_pressed() -> void:
	_computer_architecture_game_ui.visible = false
	CameraController.transit_camera_3d(CameraController.player_camera_3d)

func _on_level_1_button_pressed(): _start_level("Motherboard")

func _start_level(level_name: String) -> void:
	_computer_architecture_game_ui.visible = false
	_architecture_core_ui.visible = true
	_architecture_core.enable = true
