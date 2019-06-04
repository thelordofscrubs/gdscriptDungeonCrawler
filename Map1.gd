extends Node

var tmscene = preload("res://testleveltm.tscn")
var tmsetup = preload("res://testMapSetup.tscn")

var coordGrid = []
var lvlSize = 10
var player
var tileMap
var monsterArray = []

func _init():
	self.tileMap = tmscene.instance()
	self.add_child(self.tileMap)
	#print_tree()
	self.lvlSize = 10
	print("size of level: ", self.lvlSize)
	var lvlsetup = self.tmsetup.instance()
	var initPlayerCoords
	for x in range(self.lvlSize):
		coordGrid.append([])
		for y in range(self.lvlSize):
			match lvlsetup.get_cell(x,y):
				0:
					coordGrid[x].append("blueSlime")
					generateMonster("blueSlime",Vector2(x,y))
				1:
					coordGrid[x].append("player")
					initPlayerCoords = Vector2(x,y)
				2:
					coordGrid[x].append("chest")
				3:
					coordGrid[x].append("floor")
				4:
					coordGrid[x].append("wall")
				5:
					coordGrid[x].append("door")
				6:
					coordGrid[x].append("pot")
	var Player = preload("res://Player.gd")
	self.player = Player.new(initPlayerCoords)
	self.add_child(player)
	#var ts = ""
	#for x in range(10):
	#	for y in range(10):
	#		ts += coordGrid[x][y]
	#	ts += "\n"
	#print(ts)	

func generateMonster(type,coordinates,facing=0):
	match type:
		"blueSlime":
			var bStemp = load("res://blueSlime.gd")
			monsterArray.append(bStemp.new(coordinates,facing))
			self.add_child(monsterArray[monsterArray.size()-1])

func _ready():
	print_tree()

var monsterHitTimer = 0
func _process(delta):
	#monsterHitTimer += delta
	if Input.is_action_just_released("left"):
		self.player.updatePos(Vector2(-1,0))
	if Input.is_action_just_released("up"):
		self.player.updatePos(Vector2(0,-1))
	if Input.is_action_just_released("right"):
		self.player.updatePos(Vector2(1,0))
	if Input.is_action_just_released("down"):
		self.player.updatePos(Vector2(0,1))
	if Input.is_action_just_released("attack"):
		var a
	if Input.is_action_just_released("use"):
		var a

