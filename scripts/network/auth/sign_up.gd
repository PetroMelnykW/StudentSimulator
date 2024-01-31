extends Control

const COLLECTION_ID = "player_stats"

func _ready():
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.signup_failed.connect(on_signup_failed)

func _on_sign_up_button_pressed():
	var email = %EmailLineEdit.text
	var password = %PasswordLineEdit.text
	Firebase.Auth.signup_with_email_and_password(email, password)
	%StatusMessage.text = "Signing up"

func _send_account_data():
	var auth = Firebase.Auth.auth
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		var nickname = %NicknameLineEdit.text
		var role_id = %RoleSelectionEdit.selected
		var role
		match role_id:
			0:
				role = "Student"
			1:
				role = "Teacher"
		var data: Dictionary = {
			"nickname": nickname,
			"role": role,
		}
		var task: FirestoreTask = collection.update(auth.localid, data)

func on_signup_succeeded(auth):
	print(auth)
	Firebase.Auth.save_auth(auth)
	Firebase.Auth.load_auth()
	if Firebase.Auth.check_auth_file():
		_send_account_data()
	%StatusMessage.text
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func on_signup_failed(error_code, message):
	print(error_code)
	print(message)
	%StatusMessage.text = "Sign up failed. Error: %s" % message

func _on_move_to_login_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/auth/login.tscn")

