extends Node2D

var tmscene = preload("res://map0TM.tscn")
var tmsetup = preload("res://map0Setup.tscn")
#var healthBarScene = preload("res://healthBar.tscn")

var coordGrid = []
var lvlSize = 10
var player
var monsterId = 0
var tileMap
var monsterArray = []
var chestDict = {}
var keys = {}
var doors = {}

func _init():
	self.name = "map0"
	#self.healthBar = healthBarScene.instance()
	#self.add_child(healthBar)
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
					coordGrid[x].append("floor")#blue slime
					generateMonster("blueSlime",Vector2(x,y))
				1:
					coordGrid[x].append("floor")#player
					initPlayerCoords = Vector2(x,y)
				2:
					coordGrid[x].append("chest")
					generateChest(0,Vector2(x,y))
				3:
					coordGrid[x].append("floor")
				4:
					coordGrid[x].append("wall")
				5:
					coordGrid[x].append("door")
					doors[Vector2(x,y)] = true
				6:
					coordGrid[x].append("pot")
				7:
					coordGrid[x].append("key")
					generateSprite("key",Vector2(x,y))
	#var Player = preload("res://Player.gd")
	self.player = Player.new(initPlayerCoords)
	self.add_child(player)
	self.tileMap = tmscene.instance()
	tileMap.setStartingPos(initPlayerCoords)
	self.add_child(self.tileMap)
	#var ts = ""
	#for x in range(10):
	#	for y in range(10):
	#		ts += coordGrid[x][y]
	#	ts += "\n"
	#print(ts)	
	#var centerPixel = (initPlayerCoords+Vector2(8,8))*Vector2(32,32)
	#var centerOfScreen = OS.window_size/Vector2(2,2)
	#position = centerOfScreen-centerPixel

func setVisibility(boo):
	match boo:
		true:
			set_visible(true)
			for childNode in get_children():
				if childNode.has_method("spriteVis"):
					childNode.spriteVis(true)
		false:
			set_visible(false)
			for childNode in get_children():
				if childNode.has_method("spriteVis"):
					childNode.spriteVis(false)

func generateSprite(type, coords):
	match type:
		"key":
			var keytemp = load("res://keySprite.gd")
			keys[coords] = keytemp.new(coords)
			add_child(keys[coords])

func generateMonster(type,coordinates,facing=0):
	match type:
		"blueSlime":
			var bStemp = load("res://blueSlime.gd")
			monsterArray.append(bStemp.new(coordinates,facing, monsterId))
			self.add_child(monsterArray[monsterArray.size()-1])
	monsterId += 1

func generateChest(contentType, vector):
	var chesttemp = load("res://chest.gd")
	chestDict[vector] = chesttemp.new(contentType)

func _ready():
	print_tree()
	print(get_tree())

func moveScene(newVec):
	tileMap.move(Vector2(-1,-1)*newVec)
	for monster in monsterArray:
		monster.moveSprites(Vector2(-1,-1)*newVec)
	for key in keys.values():
		key.move(Vector2(-1,-1)*newVec)

func testMovement(dir):
	var currentPos = player.getCoordinates()
	var attemptedPos
	var attemptedVec
	match dir:
		"left":
			attemptedPos = coordGrid[currentPos[0]-1][currentPos[1]]
			attemptedVec = Vector2(-1,0)
		"right":
			attemptedPos = coordGrid[currentPos[0]+1][currentPos[1]]
			attemptedVec = Vector2(1,0)
		"up":
			attemptedPos = coordGrid[currentPos[0]][currentPos[1]-1]
			attemptedVec = Vector2(0,-1)
		"down":
			attemptedPos = coordGrid[currentPos[0]][currentPos[1]+1]
			attemptedVec = Vector2(0,1)
	var attemptedPosV = currentPos + attemptedVec
	if attemptedPos == "floor":
		player.updatePos(attemptedVec,dir)
		moveScene(attemptedVec)
	elif attemptedPos == "door":
		if doors[attemptedPosV] == true:
			if player.hasKey == true:
				player.updatePos(attemptedVec,dir)
				moveScene(attemptedVec)
				tileMap.set_cellv(attemptedPosV,3)
				doors[attemptedPosV] = false
				player.useKey()
		else:
			player.updatePos(attemptedVec,dir)
			moveScene(attemptedVec)
	elif attemptedPos == "chest":
		player.updatePos(attemptedVec,dir)
		moveScene(attemptedVec)
		openChest(attemptedPosV)
		coordGrid[currentPos[0]+attemptedVec[0]][currentPos[1]+attemptedVec[1]] = "openChest"
		tileMap.set_cellv(attemptedPosV,9)
	elif attemptedPos == "openChest":
		player.updatePos(attemptedVec,dir)
		moveScene(attemptedVec)
	elif attemptedPos == "key":
		player.updatePos(attemptedVec,dir)
		moveScene(attemptedVec)
		player.gainKey()
		coordGrid[currentPos[0]+attemptedVec[0]][currentPos[1]+attemptedVec[1]] = "floor"
		remove_child(keys[attemptedPosV])
		keys.erase(attemptedPosV)
#######
	currentPos = player.getCoordinates()
	for monster in monsterArray:
		if monster.coordinates == currentPos:
			player.takeDamage(monster.atk)

func openChest(vector):
	var chestToOpen = chestDict[vector]
	for item in chestToOpen.contents:
		match item:
			"coin":
				player.changeMoney(1)
	chestDict.erase(vector)

var monsterHitTimer = 0
func _process(delta):
	monsterHitTimer += delta
	if monsterHitTimer > .75:
		for monster in monsterArray:
			var dmg = monster.attack(player.getCoordinates())
			if dmg:
				player.takeDamage(dmg)
		monsterHitTimer = 0
	if Input.is_action_just_released("left"):
		testMovement("left")
	if Input.is_action_just_released("up"):
		testMovement("up")
	if Input.is_action_just_released("right"):
		testMovement("right")
	if Input.is_action_just_released("down"):
		testMovement("down")
	if Input.is_action_just_released("attack"):
		player.attack()
	if Input.is_action_just_released("use"):
		pass
	
