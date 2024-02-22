extends Camera3D
 
@export var _main_camera : Camera3D

func _ready() -> void:
	CameraController.current_camera_3d_changed.connect(_on_current_camera_3d_changed)

func _process(_delta) -> void:
	if _main_camera:
		global_position = _main_camera.global_position
		global_rotation = _main_camera.global_rotation

func _on_current_camera_3d_changed(new_camera_3d : Camera3D) -> void:
	_main_camera = new_camera_3d
