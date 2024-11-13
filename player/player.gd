extends CharacterBody2D

const SPEED = 30.0

@onready var anim = $AnimationPlayer

var isMoveUpPossible = true
var isMoveDownPossible = true
var isMoveLeftPossible = true
var isMoveRightPossible = true
var isInteractionPossible = true
var moves = 10
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


func _physics_process(delta: float) -> void:

	var currentPosition = Vector2(self.position.x, self.position.y)
	
	match state:
		states.IDLE:
			anim.play("Idle")
			velocity.x = 0
			velocity. y = 0
			if Input.is_action_pressed("MoveUp"):
				if isMoveUpPossible:
					destinationPosition[1] = currentPosition[1] - 100
					state = states.MOVEUP
			if Input.is_action_pressed("MoveDown"):
				if isMoveDownPossible:
					destinationPosition[1] = currentPosition[1] + 100
					state = states.MOVEDOWN
			if Input.is_action_pressed("MoveLeft"):
				if isMoveLeftPossible:
					destinationPosition[0] = currentPosition[0] - 100
					state = states.MOVELEFT
			if Input.is_action_pressed("MoveRight"):
				if isMoveRightPossible:
					destinationPosition[0] = currentPosition[0] + 100
					state = states.MOVERIGHT
			if Input.is_action_pressed("Interaction"):
				if isInteractionPossible:
					state = states.PICKUP
	
		states.MOVEUP:		
			velocity.y -= 1 * SPEED
			anim.play("WalkUp")
			if destinationPosition[1] >= currentPosition[1]:
				state = states.IDLE
			
		states.MOVEDOWN:
			velocity.y += 1 * SPEED
			anim.play("WalkDown")
			if destinationPosition[1] <= currentPosition[1]:
				state = states.IDLE
			
		states.MOVELEFT:
			velocity.x -= 1 * SPEED
			anim.play("WalkLeft")	
			if destinationPosition[0] >= currentPosition[0]:
				state = states.IDLE
			
		states.MOVERIGHT:
			velocity.x += 1 * SPEED
			anim.play("WalkRight")
			if destinationPosition[0] <= currentPosition[0]:
				state = states.IDLE
		
		states.PICKUP:
			anim.play("PickUp")
			if isAnimationFinished:
				state = states.IDLE
				isAnimationFinished = false
		
		states.DEATH:
			anim.play("Death")
			if isAnimationFinished:
				state = states.IDLE
				isAnimationFinished = false
			
	
		
	move_and_slide()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	isAnimationFinished = true
