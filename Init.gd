extends Node

var coordGrid = []
var lvlSize = 100

func _init():
	self.add_child(Player.new())
	for x in range(lvlSize):
		coordGrid.append([])
		for y in range(lvlSize):
			coordGrid[x].append(["f"])