extends StaticBody3D

@export var _luminaires : Node3D

var _is_turn_on : bool = true

func _on_interactable_focused() -> void:
	$LightSwitchModel/Cube_003.set_layer_mask_value(2, true);

func _on_interactable_unfocused() -> void:
	$LightSwitchModel/Cube_003.set_layer_mask_value(2, false);

func _on_interactable_interacted(interactor : Player) -> void:
	_is_turn_on = not _is_turn_on
	for luminaire in _luminaires.get_children():
		luminaire.switch(_is_turn_on)
