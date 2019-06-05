extends Button

func _pressed():
	var mainNode = get_parent().get_parent()
	var currentNode
	var nodeName
	for child in mainNode.get_children():
		if child.name.begins_with("map"):
			currentNode = child
			nodeName = child.name
	mainNode.remove_child(currentNode)
	mainNode.add_child(load("res://"+nodeName+".tscn").instance())
	get_tree().set_pause(false)
	mainNode.isPaused = false
	get_node("..").queue_free()
