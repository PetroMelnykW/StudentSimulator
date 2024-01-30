class_name Player
extends RigidBody3D

const RUN_SPEED_MODIFIER : float = 2

@export var _speed : float = 5
@export var _jump_force : float = 5

@onready var main_camera : Camera3D = $PlayerCamera

@onready var _grounded_ray : RayCast3D = $GroundedRay

var _velocity : Vector3 = Vector3.ZERO
var _running : bool = false

func _process(delta) -> void:
	_movement_inputs()

func _physics_process(_delta) -> void:
	_movement()

func _movement_inputs() -> void:
	#run
	_running = Input.is_action_pressed("run")
	
	#movemnt
	_velocity = Vector3.ZERO
	_velocity.x = -Input.get_action_strength("walk_left") + Input.get_action_strength("walk_right")
	_velocity.z = -Input.get_action_strength("walk_front") + Input.get_action_strength("walk_back")
	_velocity = _velocity.normalized() * _speed * (RUN_SPEED_MODIFIER if _running else 1)
	_velocity = _velocity.rotated(Vector3.UP ,deg_to_rad(main_camera.rotation_degrees.y))
	
	#jump
	if Input.is_action_just_pressed("jump") and _grounded_ray.is_colliding():
		_jump()

func _movement() -> void:
	linear_velocity.x = _velocity.x
	linear_velocity.z = _velocity.z

func _jump() -> void:
	apply_central_impulse(Vector3.UP * _jump_force)
