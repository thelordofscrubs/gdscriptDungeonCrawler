extends Sprite

func _init(coords):
	self.name = "blueSlimeSprite"
	self.texture = load("res://blueSlimeSprite.tres")
	var centerPixel = coords*Vector2(32,32)
	var centerOfScreen = OS.window_size/Vector2(2,2)
	position = centerOfScreen+centerPixel
	self.set_centered(false)
	self.set_scale(Vector2(2,2))
	self.set_offset(Vector2(0,0))

func move(v2):
	self.set_position(v2*Vector2(32,32))


func hide():
	set_visible(false)

func show():
	set_visible(true)

