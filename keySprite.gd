extends Sprite


func _init(coords):
	self.texture = load("res://key.tres")
	self.set_position(Vector2(32,32)*coords)
	self.set_centered(false)
	self.set_scale(Vector2(2,2))
	self.set_offset(Vector2(0,0))
	

