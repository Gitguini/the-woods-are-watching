extends Node2D


var gameScene

func _on_button_pressed() -> void:
	gameScene = preload("res://scenes/the_woods.tscn").instantiate()
	get_tree().root.add_child(gameScene)
	get_node("/root/TitleScreen").queue_free()
	
	pass # Replace with function body.
