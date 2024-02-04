extends Camera3D

@export var _player_camera : Camera3D

func _process(_delta) -> void:
	global_position = _player_camera.global_position
	global_rotation = _player_camera.global_rotation
