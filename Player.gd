extends Node
class_name Player
var health
var attackDamage
var money = 0
var coords
var pixelMultiplier = Vector2(32,32)
var spriteClass = preload("res://charSprite.gd")
var sprite
var facing = 0

func _init(coord = Vector2(1,1), h = 100, a = 1):
	self.coords = coord
	self.sprite = spriteClass.new(self.coords)
	self.add_child(sprite)
	#self.sprite = get_child(0)
	self.health = h
	self.attackDamage = a
	#var charImage = load("res://charSprite.png")
	#var Imaget = ImageTexture.new()
	#Imaget.create_from_image(charImage)
	#self.sprite.set_centered(false)
	#self.sprite.set_texture(Imaget)


func setHealth(h):
	self.health = h

func takeDamage(d):
	self.health -= d

func setAtk(a):
	self.attackDamage = a

func updatePos(vector):
	self.coords += vector
	self.sprite.move(self.coords)
	print("player coordinates are : "+str(self.coords[0])+", "+str(self.coords[1]))


