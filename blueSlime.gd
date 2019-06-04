extends Node

var health = 10
var atk = 5
var coordinates
var facing
var spritet = preload("res://blueSlimeSprite.gd")
var sprite

func _init(coord,f):
	self.name = "blueSlime"
	self.coordinates = coord
	self.facing = f
	self.sprite = spritet.new(coordinates)
	self.add_child(sprite)


func updatePos(change):
	self.coordinates += change

func attack(playerCoords):
	if playerCoords == coordinates:
		return 5
	else:
		return null