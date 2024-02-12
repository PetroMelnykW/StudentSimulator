extends Node

signal player_control_enable_changed(is_enable : bool)

func disable_player() -> void:
	player_control_enable_changed.emit(false)

func enable_player() -> void:
	player_control_enable_changed.emit(true)

func set_player_enable(is_enable : bool) -> void:
	player_control_enable_changed.emit(is_enable)
