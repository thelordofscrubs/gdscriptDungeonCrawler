extends Node

var health = 10
var atk = 5
var coordinates
var facing
var spritet = preload("res://blueSlimeSprite.gd")
var sprite
var id

func _init(coord,f,id):
	self.name = "blueSlime " + str(id)
	self.id = id
	self.coordinates = coord
	self.facing = f
	self.sprite = spritet.new(coordinates)
	self.add_child(sprite)

func changeHealth(amt):
	health += amt
	if health <= 0:
		get_parent().monsterArray.remove(id)
		get_parent().remove_child(self)

func updatePos(change):
	self.coordinates += change

func attack(playerCoords):
	if playerCoords == coordinates:
		return 5
	else:
		return null