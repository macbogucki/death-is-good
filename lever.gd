extends Area2D
@onready var anim = $AnimatedSprite2D
var isPlayer = false


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		isPlayer = true	
	
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		isPlayer = false

func _process(delta: float) -> void:
	if isPlayer and game.isInteraction:
		anim.frame = 1
		game.isActiveLever = true
	
