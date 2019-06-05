extends TileMap


#func _init(x,y):
#	var coords = Vector2(x,y)
#	var centerPixel = coords*Vector2(32,32)
#	var centerOfScreen = OS.window_size/Vector2(2,2)
#	position = centerOfScreen+centerPixel

func setStartingPos(coords):
	var centerPixel = (coords+Vector2(-1,-1))*Vector2(32,32)
	var centerOfScreen = OS.window_size/Vector2(2,2)
	position = centerOfScreen-centerPixel

func move(v):
	position += v*Vector2(32,32)
