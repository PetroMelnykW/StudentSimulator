extends CanvasLayer

func _on_exit_button_pressed() -> void:
	visible = false
	CameraController.transit_camera_3d(CameraController.player_camera_3d)
