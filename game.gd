extends Node

var moves = 10
var level = 1
var isPlayerAlive = true
var unlocked = 1
@onready var main_scene = get_tree().current_scene

func decreaseMove():
	moves -= 1

func gameover():
	main_scene._on_wroc_pressed()
	moves=10
	
	
func newGame():
	level = 1
	main_scene.load_new_scene()
	moves = 10
	
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
	return destination > 25
	
func isMoveDownPossible(destination: float):
	return destination < 400
	
func isMoveLeftPossible(destination: float):
	return destination > 200
	
func isMoveRightPossible(destination: float):
	return destination < 575
	
