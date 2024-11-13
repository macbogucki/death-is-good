extends CharacterBody2D


const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
@onready var anim = $AnimationPlayer

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX := Input.get_axis("MoveLeft", "MoveRight")
	var directionY := Input.get_axis("MoveUp", "MoveDown")
	
	if Input.is_action_pressed("MoveUp"):
		velocity.y = directionY * SPEED
		anim.play("WalkUp")
		
	elif Input.is_action_pressed("MoveDown"):
		velocity.y = directionY * SPEED
		anim.play("WalkDown")
		
	elif Input.is_action_pressed("MoveLeft"):
		velocity.x = directionX * SPEED
		anim.play("WalkLeft")
		
	elif Input.is_action_pressed("MoveRight"):
		velocity.x = directionX * SPEED
		anim.play("WalkRight")
		
	else:
		anim.play("Idle")
		velocity.x = 0
		velocity. y = 0
	
	
		

	move_and_slide()
