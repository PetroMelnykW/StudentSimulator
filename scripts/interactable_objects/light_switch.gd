extends StaticBody3D

@export var _luminaires : Array[Luminaire]

var _is_turn_on : bool = false

func _on_interactable_focused() -> void:
	$LightSwitchModel/Cube_003.set_layer_mask_value(2, true);

func _on_interactable_unfocused() -> void:
	$LightSwitchModel/Cube_003.set_layer_mask_value(2, false);

func _on_interactable_interacted() -> void:
	_is_turn_on = not _is_turn_on
	for luminaire : Luminaire in _luminaires:
		luminaire.switch(_is_turn_on)
