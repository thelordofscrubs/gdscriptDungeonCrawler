extends Node

var health = 10
var maxHealth = 10
var atk = 5
var coordinates
var facing
var spritet = preload("res://blueSlimeSprite.gd")
var sprite
var id
var healthBar
var healthBart = preload("res://monsterHealthBar.gd")

func _init(coord,f,id):
	self.name = "blueSlime " + str(id)
	self.id = id
	self.coordinates = coord
	self.facing = f
	self.sprite = spritet.new(coordinates)
	self.add_child(sprite)
	self.healthBar = healthBart.new(coordinates, maxHealth, name)
	self.add_child(healthBar)

func spriteVis(boo):
	match boo:
		false:
			remove_child(sprite)
			remove_child(healthBar)
		true:
			sprite = spritet.new(coordinates)
			add_child(sprite)
			healthBar = healthBart.new(coordinates, maxHealth, name)
			add_child(healthBar)
			

func changeHealth(amt):
	health += amt
	if health > maxHealth:
		health = maxHealth
	healthBar.changeValue(health)
	if health <= 0:
		get_parent().monsterArray.remove(id)
		get_parent().remove_child(self)

func updatePos(change):
	self.coordinates += change
	sprite.move(coordinates)

func attack(playerCoords):
	if playerCoords == coordinates:
		return atk
	else:
		return null