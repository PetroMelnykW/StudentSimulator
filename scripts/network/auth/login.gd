extends Control

const COLLECTION_ID = "player_stats"

func _ready():
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	
	if Firebase.Auth.check_auth_file():
		%StatusMessage.text = "Logging in"
		get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_sign_up_button_pressed():
	var email = %EmailLineEdit.text
	var password = %PasswordLineEdit.text
	Firebase.Auth.login_with_email_and_password(email, password)
	%StatusMessage.text = "Logging in"

func on_login_succeeded(auth):
	print(auth)
	Firebase.Auth.save_auth(auth)
	%StatusMessage.text
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	%StatusMessage.text = "Login failed. Error: %s" % message

func _on_move_to_sign_up_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/auth/sign_up.tscn")
