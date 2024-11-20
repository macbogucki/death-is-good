extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		game.deathPlayer()


func _process(delta: float) -> void:
	if game.isActiveLever == true:
		self.visible = true
