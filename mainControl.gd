extends Control

var levelActive = false
var isPaused = false
var menuScene = preload("res://menu.tscn")
var pauseMenu

func setLevelActive(s):
	levelActive = s

func setIsPaused(s):
	isPaused = s
	if s == false:
		get_tree().set_pause(false)

func _process(delta):
	if Input.is_action_just_released("menu"):
		if levelActive == true:
			match isPaused:
				false:
					isPaused = true
					get_node("map0").setVisibility(false)
					self.pauseMenu = menuScene.instance()
					add_child(self.pauseMenu)
					get_tree().set_pause(true)
				true:
					get_tree().set_pause(false)
					isPaused = false
					get_node("map0").setVisibility(true)
					get_node("menu").queue_free()