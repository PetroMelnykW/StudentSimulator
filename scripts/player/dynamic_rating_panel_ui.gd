extends Control

const COLLECTION_ID = 'player_stats'
const COLLECTION_LEADER_ID = 'leaderboard'


@onready var _student_panels : Control = $VBoxContainer/MarginContainer/VBoxContainer

func _ready() -> void:
	_update_students_panel_data()

func _update_students_panel_data() -> void:
	while true:
		var result: Array[Dictionary] = await _get_top_player_list()
		
		if (result != null):
			var panel_count = _student_panels.get_child_count()
			for i in range(panel_count):
				var student_data = result[i] if i < len(result) else null
				_update_student_panel(_student_panels.get_child(i), student_data)
		else:
			printerr("Students rating data was not recieved")
			
		await get_tree().create_timer(5).timeout

func _get_top_player_list() -> Array[Dictionary]:
	var doc: Dictionary
	var auth = Firebase.Auth.auth
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_LEADER_ID)
		var task = collection.get_doc("rating")
		var result = await task.get_document
		doc = result["doc_fields"]
	
	var top_students: Array[Dictionary]
	while len(doc) > 0:
		var max_value = -INF
		var max_value_key = ""
		for key in doc:
			if doc[key] > max_value:
				max_value = doc[key]
				max_value_key = key
		top_students.append({"nickname": max_value_key, "score": max_value})
		doc.erase(max_value_key)
		
	return top_students

func _update_student_panel(panel: Panel, student_data: Variant) -> void:
	if student_data == null:
		panel.hide()
	else:
		var panel_h_box = panel.get_node("MarginContainer").get_node("HBoxContainer")
		panel_h_box.get_node("PlayerNameLabel").text = student_data.nickname + ":"
		panel_h_box.get_node("PlayerScoreLabel").text = str(student_data.score)
		panel.show()
