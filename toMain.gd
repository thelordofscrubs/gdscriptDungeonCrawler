extends Button


func _pressed():
	var nodes = get_parent().get_parent().get_children()
	var currentMap
	for node in nodes:
		if node.name.begins_with("map"):
			currentMap = node
	currentMap.queue_free()
	var rootNode = get_parent().get_parent()
	rootNode.setLevelActive(false)
	rootNode.setIsPaused(false)
	get_node("../../mainMenu").set_visible(true)
	get_parent().queue_free()