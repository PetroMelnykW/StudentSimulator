class_name Player
extends RigidBody3D

const RUN_SPEED_MODIFIER : float = 2

@export var _speed : float = 5
@export var _jump_force : float = 5

@onready var main_camera : Camera3D = $PlayerCamera

@onready var _grounded_ray : RayCast3D = $GroundedRay
@onready var _ui_canvas : CanvasLayer = $PlayerUI

var _velocity : Vector3 = Vector3.ZERO
var _running : bool = false
var _enable : bool = true

func _ready() -> void:
	PlayerController.player_control_enable_changed.connect(_on_player_control_enable_changed)

func _process(delta) -> void:
	if _enable:
		_movement_inputs()

func _physics_process(_delta) -> void:
	if _enable:
		_movement()

func _movement_inputs() -> void:
	#run
	_running = Input.is_action_pressed("run")
	
	#movemnt
	_velocity = Vector3.ZERO
	_velocity.x = -Input.get_action_strength("walk_left") + Input.get_action_strength("walk_right")
	_velocity.z = -Input.get_action_strength("walk_front") + Input.get_action_strength("walk_back")
	_velocity = _velocity.normalized() * _speed * (RUN_SPEED_MODIFIER if _running else 1)
	_velocity = _velocity.rotated(Vector3.UP ,deg_to_rad(main_camera.global_rotation_degrees.y))
	
	#jump
	if Input.is_action_just_pressed("jump") and _grounded_ray.is_colliding():
		_jump()

func _movement() -> void:
	linear_velocity.x = _velocity.x
	linear_velocity.z = _velocity.z

func _jump() -> void:
	apply_central_impulse(Vector3.UP * _jump_force)

func _on_player_control_enable_changed(is_enable : bool) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if is_enable else Input.MOUSE_MODE_VISIBLE)	
	_enable = is_enable
	_ui_canvas.visible = is_enable
	
	linear_velocity.x = 0
	linear_velocity.z = 0
