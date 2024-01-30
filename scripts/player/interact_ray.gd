extends RayCast3D

@export_category("Dependencies")
@export var _player : Player
@export var _name_panel : Control
@export var _name_label : Label
@export var _description_panel : Control
@export var _description_label : Label
@export var _interact_button_tip : Control

var _last_interactable_object : Interactable = null

func _process(_delta) -> void:
	_apply_ray();
	_check_inputs();

func _apply_ray() -> void:
	var interactable_object : Interactable = get_collider()
	
	#ui
	if interactable_object != null:
		if _interact_button_tip: 
			_interact_button_tip.visible = interactable_object.is_can_interacted
			
		if _name_panel: 
			_name_panel.visible = interactable_object.is_show_name_info
			if _name_label: 
				_name_label.text = interactable_object.object_name
				
		if _description_panel: 
			_description_panel.visible = interactable_object.is_show_description_info
			if _description_label: 
				_description_label.text = interactable_object.object_description
	else:
		if _interact_button_tip: 
			_interact_button_tip.visible = false
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

func _check_inputs() -> void:
	if Input.is_action_just_pressed("interact"):
		if _last_interactable_object != null and _last_interactable_object.is_can_interacted:
			_last_interactable_object.interact(_player)
