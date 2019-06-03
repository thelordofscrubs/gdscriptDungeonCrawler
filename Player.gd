extends Node
class_name Player
var health = 1
var attackDamage = 1
var coords = Vector2(1,1)
var pixelMultiplier = Vector2(16,16)
var sprite = preload("res://charSprite.gd")
var sprite1
var facing = 0

func _init(h = 100, a = 1):
	self.sprite1 = sprite.new()
	self.add_child(sprite1)
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

func setAtk(a):
	self.attackDamage = a

func updatePos():
	self.sprite1.move(self.coords * self.pixelMultiplier)


func _process(delta):
	if Input.is_action_just_released("left"):
		self.coords[0] -= 1
		updatePos()
		
	if Input.is_action_just_released("up"):
		self.coords[1] -= 1
		updatePos()
	if Input.is_action_just_released("right"):
		self.coords[0] += 1
		updatePos()
	if Input.is_action_just_released("down"):
		self.coords[1] += 1
		updatePos()
	if Input.is_action_just_released("attack"):
		var a
	if Input.is_action_just_released("use"):
		var a

