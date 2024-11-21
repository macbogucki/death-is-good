extends Node

var moves = 10
var level = 1
var isPlayerAlive = true
var unlocked = 1
var grid_size = Vector2(0,0)
var grid_position = Vector2(0,0)
var	board = []
var isInteraction = false
var isActiveLever = false
var number_of_levels = 6
var keys = 0
var isObstacle = false

@onready var main_scene = get_tree().current_scene

func decreaseMove():
	moves -= 1
	main_scene.moves_update()

func gameover():
	main_scene._on_wroc_pressed()
	main_scene.koniec(0)
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
			isObstacle = false
		2:
			grid_size = Vector2(3,6)
			grid_position = Vector2(2,1)
			moves = 7
			isObstacle = false
		3:
			grid_size = Vector2(7,4)
			grid_position = Vector2(4,4)
			moves = 9
			isObstacle = false
		4:
			grid_size = Vector2(4,4)
			grid_position = Vector2(4,2)
			moves = 10
			isObstacle = false
		5:
			grid_size = Vector2(9,6)
			grid_position = Vector2(8,3)
			moves = 11
			isObstacle = false
		6:
			grid_size = Vector2(9,6)
			grid_position = Vector2(8,3)
			moves = 23
			board = [[0,0,0,0,1,1,0,0,0],
					 [1,1,1,0,1,1,1,0,1],
					 [1,1,1,0,1,1,1,0,1],
					 [0,1,1,0,0,0,1,0,1],
					 [0,0,0,0,0,0,0,0,1],
					 [0,1,1,0,0,0,1,1,1]]
			isObstacle = true
	main_scene.moves_update()
			
func changeLevel():
	isPlayerAlive = true
	isActiveLever = false
	if unlocked == level: 
		unlocked += 1
	level += 1
	if level <= number_of_levels:
		main_scene.load_new_scene()
	else: 
		main_scene.zamknij_poziom()
		main_scene.koniec(1)
	#else:
	#	get_tree
	
func isPlayerLive():
	return isPlayerAlive
	
func deathPlayer():
	isPlayerAlive = false
	
func isMoveUpPossible(destination: float):
	if grid_position.y > 1:
		if isObstacle == false:
			grid_position.y -= 1
			return true
		else:
			print(board[grid_position.y - 2][grid_position.x - 1])
			if board[grid_position.y - 2][grid_position.x - 1] == 1:
				return false
			else:
				grid_position.y -= 1
				return true
	else:
		return false
	
func isMoveDownPossible(destination: float):
	if grid_position.y < grid_size.y:
		if isObstacle == false:
			grid_position.y += 1
			return true
		else:
			print(board[grid_position.y][grid_position.x - 1])
			if board[grid_position.y][grid_position.x - 1] == 1:
				return false
			else:
				grid_position.y += 1
				return true
	else:
		return false
	
func isMoveLeftPossible(destination: float):
	if grid_position.x > 1:
		if isObstacle == false:
			grid_position.x -= 1
			return true
		else:
			print(board[grid_position.y - 1][grid_position.x - 2])
			if board[grid_position.y - 1][grid_position.x - 2] == 1:
				return false
			else:
				grid_position.x -= 1
				return true
	else:
		return false
func isMoveRightPossible(destination: float):
	if grid_position.x < grid_size.x:
		if isObstacle == false:
			grid_position.x += 1
			return true
		else:
			print(board[grid_position.y - 1][grid_position.x])
			if board[grid_position.y - 1][grid_position.x] == 1:
				return false
			else:
				grid_position.x += 1
				return true
	else:
		return false
