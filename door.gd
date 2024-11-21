extends StaticBody2D




func _on_area_2d_body_entered(body: Node2D) -> void:
	if game.keys > 0:
		game.keys -= 1
		var tween = get_tree().create_tween()
		tween.tween_property(get_node("Sprite2D"), "modulate:a", 0, 1)
		tween.tween_callback(self.queue_free)
