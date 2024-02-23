extends Control

var _is_open = false

func _input(event):
	if (Input.is_action_just_pressed("change_cursor_visible")
	and not _is_open
	and PlayerState.current_mode == PlayerState.GameMode.WALK):
		_is_open = true
		show()
		$AnimationPlayer.play("show")
		PlayerState.change_mode(PlayerState.GameMode.MAIN_MENU)
	elif (Input.is_action_just_pressed("change_cursor_visible")
	and _is_open
	and PlayerState.current_mode == PlayerState.GameMode.MAIN_MENU):
		_is_open = false
		$AnimationPlayer.play("hide")
		await $AnimationPlayer.animation_finished
		hide()
		PlayerState.change_mode(PlayerState.GameMode.WALK)

func _on_resume_button_pressed():
	_is_open = false
	$AnimationPlayer.play("hide")
	await $AnimationPlayer.animation_finished
	hide()
	PlayerState.change_mode(PlayerState.GameMode.WALK)

func _on_settings_button_pressed():
	pass # Replace with function body.

func _on_creators_button_pressed():
	pass # Replace with function body.

func _on_log_out_button_pressed():
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://scenes/ui/auth/login.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
