extends Button

func _on_pressed():
	$"../ChooseInputButton".visible = true
	var delete_node
	if get_parent().has_node("WriteValueEdit"):
		delete_node = $"../WriteValueEdit"
	elif get_parent().has_node("ChooseVarButton"):
		delete_node = $"../ChooseVarButton"
	elif get_parent().has_node("ExpressionPanel"):
		delete_node = $"../ExpressionPanel"
	elif get_parent().has_node("ChooseFunctionButton"):
		delete_node = $"../ChooseFunctionButton"
	get_parent().remove_child(delete_node)
	delete_node.queue_free()
	get_parent().remove_child(self)
	queue_free()
