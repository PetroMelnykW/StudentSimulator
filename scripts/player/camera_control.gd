class_name CameraControl
extends Camera3D

const MIN_LOOK_ANGLE : float = -50
const MAX_LOOK_AMGLE : float = 85

@export var _sensitivity : float = 0.2

var _mouseDelta : Vector2 = Vector2.ZERO

func set_camera_rotation(new_rotation : Vector3) -> void:
	_mouseDelta.x = -new_rotation.y
	_mouseDelta.y = -new_rotation.x
	rotation_degrees.x = -_mouseDelta.y
	rotation_degrees.y = -_mouseDelta.x

func _ready() -> void:
	_change_cursor_visible()

func _process(_delta) -> void:
	if Input.is_action_just_pressed("change_cursor_visible"):
		_change_cursor_visible()

func _input(event) -> void:
	if event is InputEventMouseMotion:
		_update_camera_movement(event)

func _update_camera_movement(event_data : InputEventMouseMotion) -> void:
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		return
	
	_mouseDelta += event_data.relative * _sensitivity
	_mouseDelta.y = clamp(_mouseDelta.y, MIN_LOOK_ANGLE, MAX_LOOK_AMGLE)
	
	rotation_degrees.x = -_mouseDelta.y
	rotation_degrees.y = -_mouseDelta.x

func _change_cursor_visible() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED 
						if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED
						else Input.MOUSE_MODE_VISIBLE)
