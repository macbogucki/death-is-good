extends Node

var moves = 10
var level = 1
var isPlayerAlive = true
var unlocked = 1
var grid_size = Vector2(0,0)
var grid_position = Vector2(0,0)
var	board = []

@onready var main_scene = get_tree().current_scene

func decreaseMove():
	moves -= 1

func gameover():
	main_scene._on_wroc_pressed()
	moves=10
	
	
#func newGame():
	#level = 1
	#main_scene.load_new_scene()
	#moves = 10

func setGrid():
	match level:
		1:
			grid_size = Vector2(5,3)
			grid_position = Vector2(1,2)
			moves = 5
	
		2:
			grid_size = Vector2(3,6)
			grid_position = Vector2(2,1)
			moves = 7
		
		3:
			grid_size = Vector2(7,4)
			grid_position = Vector2(4,4)
			moves = 9
			
		4:
			grid_size = Vector2(4,4)
			grid_position = Vector2(4,2)
			moves = 9
			
		5:
			grid_size = Vector2(9,6)
			grid_position = Vector2(9,3)
			moves = 11
			
		6:
			grid_size = Vector2(9,6)
			grid_position = Vector2(9,3)
			moves = 11
			
func changeLevel():
	isPlayerAlive = true
	if unlocked == level: 
		unlocked += 1
	level += 1
	main_scene.load_new_scene()
	if level == 1:
		
		moves = 10
	elif level == 2:
		moves = 10
	# end of game
	#else:
	#	get_tree
	
func isPlayerLive():
	return isPlayerAlive
	
func deathPlayer():
	isPlayerAlive = false
	
func isMoveUpPossible(destination: float):
	print(grid_position.y)
	if grid_position.y > 1:
		grid_position.y -= 1
		return true
	else:
		return false
	#return destination > 25
	#return true
	
func isMoveDownPossible(destination: float):
	if grid_position.y < grid_size.y:
		grid_position.y += 1
		return true
	else:
		return false
	
func isMoveLeftPossible(destination: float):
	if grid_position.x > 1:
		grid_position.x -= 1
		return true
	else:
		return false
func isMoveRightPossible(destination: float):
	if grid_position.x < grid_size.x:
		grid_position.x += 1
		return true
	else:
		return false
