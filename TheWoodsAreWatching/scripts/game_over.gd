extends Node2D


var menuScene
@export var packedMenu: PackedScene

func _on_button_pressed() -> void:
	menuScene = packedMenu.instantiate()
	get_tree().root.add_child(menuScene)
	get_node("/root/GameOver").queue_free()
