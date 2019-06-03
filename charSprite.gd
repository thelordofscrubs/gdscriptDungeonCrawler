extends Sprite
class_name charSprite

func _init():
	self.texture = load("res://charSpriteTexture.tres")
	self.set_position(Vector2(16,16))
	self.set_centered(false)

func move(v2):
	self.set_position(v2)


