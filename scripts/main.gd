class_name Main
extends Node3D

@export var _player : Player
@export var _current_room : Room

func change_room(scene_path : String) -> void:
	_player.hide()
	_current_room.hide()
	_current_room.queue_free()
	_current_room = load(scene_path).instantiate()
	add_child(_current_room)
	_current_room.position = Vector3.ZERO
	_player.global_position = _current_room.get_player_start_global_position()
	var player_camera : CameraControl = _player.main_camera
	player_camera.set_camera_rotation(_current_room.get_player_start_global_rotation())
	_player.show()