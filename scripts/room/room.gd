class_name Room
extends Node3D

@export var _player_start_position : Node3D

func get_player_start_global_position() -> Vector3:
	return _player_start_position.global_position

func get_player_start_global_rotation() -> Vector3:
	return _player_start_position.rotation_degrees
