class_name ArchitectureCore
extends Node3D

var enable: bool = false

var _motherboard: Node3D
var _processor: Node3D

var _last_interactable_object: Interactable

@onready var _motherboard_place = $MotherboardPlace
@onready var _main_camera: Camera3D = $"../Camera3D"

#ui
@onready var _name_panel: Control = $PCBuildingInteracableCanvas/Control/NamePanel
@onready var _description_panel: Control = $PCBuildingInteracableCanvas/Control/DescriptionPanel
@onready var _name_label: Label = $PCBuildingInteracableCanvas/Control/NamePanel/NameLabel
@onready var _description_label: Label = $PCBuildingInteracableCanvas/Control/DescriptionPanel/MarginContainer/VBoxContainer/ContentLabel

func _ready() -> void:
	CameraController.current_camera_3d_changed.connect(_on_current_camera_3d_changed)

func _process(_delta: float) -> void:
	if enable:
		_apply_ray()
		_chech_inputs()

func _apply_ray() -> void:
	#send ray
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 20
	var from = _main_camera.project_ray_origin(mouse_pos)
	var to = from + _main_camera.project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collide_with_areas = true
	ray_query.collision_mask = 0b1000 #4
	var raycast_result: Dictionary = space.intersect_ray(ray_query)
	
	#check result
	var interactable_object: Interactable = null
	if raycast_result.has("collider"):
		for child_node in raycast_result.collider.get_children():
			if child_node is Interactable:
				interactable_object = child_node
				break
	
	#ui
	if interactable_object != null:
		if _name_panel: 
			_name_panel.visible = interactable_object.is_show_name_info
			_name_panel.position = (mouse_pos + Vector2(0, -_name_panel.get_rect().size.y))
			if _name_label: 
				_name_label.text = interactable_object.object_name
				
		if _description_panel: 
			_description_panel.visible = interactable_object.is_show_description_info
			if _description_label: 
				_description_label.text = interactable_object.object_description
	else:
		if _name_panel: 
			_name_panel.visible = false
		if _description_panel: 
			_description_panel.visible = false
	
	#outline
	if interactable_object != _last_interactable_object:
		if _last_interactable_object != null:
			_last_interactable_object.unfocus()
		
		if interactable_object != null:
			interactable_object.focus()
		
		_last_interactable_object = interactable_object

func _chech_inputs() -> void:
	if Input.is_action_just_pressed("click") and _last_interactable_object:
		_last_interactable_object.interact()

func _on_current_camera_3d_changed(new_camera: Camera3D) -> void:
	if enable:
		_main_camera = new_camera
