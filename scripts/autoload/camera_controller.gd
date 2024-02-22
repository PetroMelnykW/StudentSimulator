extends Node

signal current_camera_3d_changed(new_camera : Camera3D)

var player_camera_3d : Camera3D:
	set(value):
		player_camera_3d = value
		_change_current_camera_3d(player_camera_3d)

var _current_camera_3d : Camera3D

@onready var _transition_camera_3d : Camera3D = $TransitionCamera

func transit_camera_3d(to : Camera3D, duration : float = 2) -> void:
	PlayerState.change_mode(PlayerState.GameMode.TRANSITION_CAMERA)
	_transition_camera_3d.fov = _current_camera_3d.fov
	_transition_camera_3d.cull_mask = _current_camera_3d.cull_mask
	_transition_camera_3d.global_transform = _current_camera_3d.global_transform
	
	_change_current_camera_3d(_transition_camera_3d)
	
	var transform_tween : Tween = create_tween()
	var fov_tween : Tween = create_tween()
	transform_tween.tween_property(_transition_camera_3d, "global_transform", to.global_transform, duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	fov_tween.tween_property(_transition_camera_3d, "fov", to.fov, duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	transform_tween.play()
	fov_tween.play()
	
	await transform_tween.finished
	await fov_tween.finished
	
	_change_current_camera_3d(to)
	if to == player_camera_3d:
		PlayerState.change_mode(PlayerState.GameMode.WALK)

func _change_current_camera_3d(new_camera : Camera3D) -> void:
	_current_camera_3d = new_camera
	new_camera.make_current()
	current_camera_3d_changed.emit(new_camera)
