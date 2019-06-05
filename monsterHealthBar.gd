extends "res://healthBar.gd"

var coords = Vector2(1,1)

func _init(coords, maxV, name):
	self.name = name + " healthbar"
	self.max_value = maxV
	self.value = maxV
	self.coords = coords * Vector2(32,32)
	self.rect_size = Vector2(217,27)
	self.rect_scale = Vector2(.2,.1)
	self.rect_position = Vector2(self.coords[0]-(rect_size[0]*rect_scale[0]-32)/2,self.coords[1]+32)
	self.texture_under = preload("res://healthBarBackground.png")
	self.texture_progress = preload("res://healthBarForeground.png")

func move(newCoords):
	coords = newCoords
	self.rect_position = Vector2(self.coords[0]-(rect_size[0]*rect_scale[0]-32)/2,self.coords[1]+32)

