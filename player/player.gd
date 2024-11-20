extends CharacterBody2D

const SPEED = 120.0
const distanceInOneMove = 64.0
@onready var anim = $AnimationPlayer

var isInteractionPossible = true
var destinationPosition = Vector2(0, 0)
var isAnimationFinished = false
var state = 0

enum states {
	IDLE = 0, 
	MOVEUP = 1, 
	MOVEDOWN = 2, 
	MOVELEFT = 3, 
	MOVERIGHT = 4, 
	PICKUP = 5, 
	DEATH = 6}

# these numbers should update with changing size of maps, currently they can const


func _physics_process(delta: float) -> void:

	var currentPosition = Vector2(self.position.x, self.position.y)
	
	match state:
		states.IDLE:
			anim.play("Idle")
			velocity.x = 0
			velocity.y = 0
			#position = currentPosition
				
			if Input.is_action_pressed("MoveUp"):									
				destinationPosition[1] = currentPosition[1] - distanceInOneMove
				if game.isMoveUpPossible(destinationPosition[1]):
					state = states.MOVEUP
					
			if Input.is_action_pressed("MoveDown"):				
				destinationPosition[1] = currentPosition[1] + distanceInOneMove
				if game.isMoveDownPossible(destinationPosition[1]):
					state = states.MOVEDOWN
					
			if Input.is_action_pressed("MoveLeft"):
				destinationPosition[0] = currentPosition[0] - distanceInOneMove
				if game.isMoveLeftPossible(destinationPosition[0]):
					state = states.MOVELEFT
					
			if Input.is_action_pressed("MoveRight"):
				destinationPosition[0] = currentPosition[0] + distanceInOneMove
				if game.isMoveRightPossible(destinationPosition[0]):
					state = states.MOVERIGHT
					
			if Input.is_action_pressed("Interaction"):
				if isInteractionPossible:
					state = states.PICKUP
	
		states.MOVEUP:		
			if destinationPosition[1] >= position.y:
				velocity.y = 0
				if isPlayerLive():
					state = states.IDLE
					game.decreaseMove()
			else:
				velocity.y = -1 * SPEED
				position.y += velocity.y * delta
				anim.play("WalkUp")
			
			
		states.MOVEDOWN:			
			if destinationPosition[1] <= position.y:
				velocity.y = 0
				if isPlayerLive():
					state = states.IDLE
					game.decreaseMove()
			else:
				velocity.y = 1 * SPEED
				position.y += velocity.y * delta
				anim.play("WalkDown")
				
		states.MOVELEFT:
			if destinationPosition[0] >= position.x:
				velocity.x = 0
				if isPlayerLive():
					state = states.IDLE
					game.decreaseMove()
			else:		
				velocity.x = -1 * SPEED
				position.x += velocity.x * delta
				anim.play("WalkLeft")	
			
			
		states.MOVERIGHT:
			if destinationPosition[0] <= position.x:
				velocity.x = 0				
				if isPlayerLive():			
					state = states.IDLE
					game.decreaseMove()
			else:	
				velocity.x = 1 * SPEED		
				position.x += velocity.x * delta	
				anim.play("WalkRight")
			
		
		states.PICKUP:
			anim.play("PickUp")
			if isAnimationFinished:
				state = states.IDLE
				isAnimationFinished = false
		
		states.DEATH:
			velocity.x = 0
			velocity.y = 0
			anim.play("Death")
			if isAnimationFinished:
				state = states.IDLE
				isAnimationFinished = false
				game.changeLevel()
			
	if game.moves == 0:
		velocity.x = 0
		velocity.y = 0
		game.gameover()
		#game over
		#state = states.DEATH
			
	move_and_slide()

func isPlayerLive():
	if game.isPlayerLive() == false:
		state = states.DEATH
		return false
	return true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	isAnimationFinished = true
