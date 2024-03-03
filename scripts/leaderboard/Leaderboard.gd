extends Control

var COLLECTION_ID = 'leaderboard'
var collection: FirestoreCollection
func _ready():
	collection = Firebase.Firestore.collection(COLLECTION_ID)
	get_leader()

#func _on_button_pressed():
	#var auth = Firebase.Auth.auth
	#var username = %NikName.text
	#var score = %Score.text.to_int()
#
	#var data: Dictionary = {
		#username: score
	#}
	#var task: FirestoreTask = collection.update('rating', data)

func get_leader():
	var task = collection.get_doc('rating')
	var result = await task.get_document
	print(result)
	if result:
		var leaderboard_data = result['doc_fields']
		leaderboard_data = sort_dictionary(leaderboard_data)
		print(sort_dictionary(leaderboard_data))
		var usernames = leaderboard_data.keys()
		var label = %Leaderboard
		var label_text = ''
		var i = 0
		for username in usernames:
			i += 1
			var score = leaderboard_data[username]
			label_text += ' '+ str(i) +': ' + username + ' : ' + str(score) + '\n'
		label.text = label_text

func sort_dictionary(dict):
	var keys = dict.keys()
	var sort_by_value = func(a, b):
		return dict[b] < dict[a]
	keys.sort_custom(sort_by_value) 
	var sorted_dict = Dictionary()
	for key in keys:
		sorted_dict[key] = dict[key]
	return sorted_dict
	
func _on_back_to_game_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
