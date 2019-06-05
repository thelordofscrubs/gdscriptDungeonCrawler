extends "res://mainMenuButton.gd"

var lvlId = text.lstrip("Level ").to_int()

func _pressed():
	mainControlNode.get_node("mainMenu").set_visible(false)
	var map = "res://map"+str(lvlId)+".tscn"
	map = load(map)
	mainControlNode.add_child(map.instance())
	mainControlNode.setLevelActive(true)


