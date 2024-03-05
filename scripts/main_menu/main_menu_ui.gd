extends Control

var _is_open = false
var score: int = 0
var COLLECTION_ID = 'player_stats'
var COLLECTION_LEADER_ID = 'leaderboard'
var collection: FirestoreCollection
var auth = Firebase.Auth.auth


func _input(event):
	if (Input.is_action_just_pressed("change_cursor_visible")
	and not _is_open
	and PlayerState.current_mode == PlayerState.GameMode.WALK):
		_is_open = true
		get_score()
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
	get_tree().change_scene_to_file("res://scenes/ui/auth/leaderboard.tscn")

func _on_log_out_button_pressed():
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://scenes/ui/auth/login.tscn")

func _on_exit_button_pressed():
	if await add_to_lederboard():
		get_tree().quit()

func add_to_lederboard():
	collection = Firebase.Firestore.collection(COLLECTION_ID)
	var reting = Firebase.Firestore.collection(COLLECTION_LEADER_ID)
	var user = collection.get_doc(auth.localid)
	var result = await user.get_document
	var username = result['doc_fields']['nickname']
	var score = result['doc_fields']['score']
	var data: Dictionary = {
		username: score
	}
	var task: FirestoreTask = reting.update('rating', data)
	
	if await task.task_finished:
		return true
	
func get_score():
	collection = Firebase.Firestore.collection(COLLECTION_ID)
	var task = collection.get_doc(auth.localid)
	var result = await task.get_document
	%Score.text = "Score: " + str(result['doc_fields']['score'])
