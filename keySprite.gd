extends Sprite


func _init(coords):
	self.texture = load("res://key.tres")
	var centerPixel = coords*Vector2(32,32)
	var centerOfScreen = OS.window_size/Vector2(2,2)
	position = centerOfScreen+centerPixel
	print(centerOfScreen)
	print(position)
	self.set_centered(false)
	self.set_scale(Vector2(2,2))
	self.set_offset(Vector2(0,0))
	self.set_z_index(5)

func move(vec):
	position += vec*Vector2(32,32)

