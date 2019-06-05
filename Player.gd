extends Node
class_name Player
var health
var attackDamageMult = 1
var weaponMult = 5
var atkDmg = attackDamageMult * weaponMult
var money = 0
var coords
var pixelMultiplier = Vector2(32,32)
var spriteClass = preload("res://charSprite.gd")
var sprite
var facing = "down"
var parentNode
var hasKey = false
var isAttacking = false

func _init(coord = Vector2(1,1), h = 100, a = 1):
	self.name = "PlayerNode"
	self.coords = coord
	self.sprite = spriteClass.new(self.coords)
	self.add_child(sprite)
	#self.sprite = get_child(0)
	self.health = h
	self.attackDamageMult = a
	#var charImage = load("res://charSprite.png")
	#var Imaget = ImageTexture.new()
	#Imaget.create_from_image(charImage)
	#self.sprite.set_centered(false)
	#self.sprite.set_texture(Imaget)
	

func _ready():
	self.parentNode = get_parent()

func attack():
	if isAttacking == true:
		return
	isAttacking = true
	var t = Timer
	var spriteTimer = t.new()
	spriteTimer.set_one_shot(true)
	add_child(spriteTimer)
	spriteTimer.connect("timeout",self,"_spriteTimerTO")
	sprite.set_texture(load("res://charWSword.tres"))
	spriteTimer.start(1)
	var atkCoords
	match facing:
		"left":
			atkCoords = coords + Vector2(-1,0)
		"up":
			atkCoords = coords + Vector2(0,-1)
		"right":
			atkCoords = coords + Vector2(1,0)
		"down":
			atkCoords = coords + Vector2(0,1)
	print("attacking coordinates: " + str(atkCoords[0]) +", "+ str(atkCoords[1]))
	for monster in parentNode.monsterArray:
		if monster.coordinates == atkCoords:
			monster.changeHealth(-atkDmg)
			print("hit monster: "+monster.name+" at coords: " + str(atkCoords[0]) +", "+ str(atkCoords[1]))

func _spriteTimerTO():
	sprite.set_texture(load("res://charSpriteTexture.tres"))
	isAttacking = false

func changeMoney(amt):
	money += amt
	var moneyDisplay = get_node_or_null("../MoneyPanel/MoneyDisplay")
	moneyDisplay.set_text("Money: " + str(money))

func getCoordinates():
	return coords

func setHealth(h):
	self.health = h
	updateHealthBar()

func takeDamage(d):
	self.health -= d
	updateHealthBar()

func gainKey():
	self.hasKey = true

func useKey():
	self.hasKey = false

func setAtk(a):
	self.attackDamageMult = a

func updatePos(vector,dir):
	self.facing = dir
	self.coords += vector
	self.sprite.move(self.coords)
	print("player coordinates are : "+str(self.coords[0])+", "+str(self.coords[1]))

func updateHealthBar():
	var healthBarNode = self.get_node_or_null("../TextureProgress")
	healthBarNode.changeValue(health)