extends StaticBody3D

var _is_pc_turn_on : bool = false

func _on_pc_interacted(interactor : Player) -> void:
	_is_pc_turn_on = not _is_pc_turn_on
	$monitor/BlackScreen.visible = not _is_pc_turn_on
	$monitor/WhiteScreen.visible = _is_pc_turn_on

func _on_monitor_interacted(interactor : Player) -> void:
	if _is_pc_turn_on:
		_show_os(interactor)

func _show_os(interactor : Player) -> void:
	var main : Main = get_tree().current_scene
	main.switch_os(true)
