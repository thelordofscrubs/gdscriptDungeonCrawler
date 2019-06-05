extends Sprite
class_name charSprite

func _init(coords):
	self.name = "playerSprite"
	self.texture = load("res://charSpriteTexture.tres")
	self.set_position(Vector2(32,32)*coords)
	self.set_centered(false)
	self.set_scale(Vector2(2,2))
	self.set_offset(Vector2(0,0))

func move(v2):
	self.set_position(v2*Vector2(32,32))

func hide():
	set_visible(false)

func show():
	set_visible(true)

