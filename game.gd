extends Node

var moves = 10
var level = 1
var isPlayerAlive = true


func decreaseMove():
	moves -= 1

func newGame():
	get_tree().change_scene_to_file("res://levels/level1.tscn")
	moves = 10
	
func changeLevel():
	isPlayerAlive = true
	level += 1
	if level == 1:
		get_tree().change_scene_to_file("res://levels/level1.tscn")
		moves = 10
	elif level == 2:
		get_tree().change_scene_to_file("res://levels/level2.tscn")
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
