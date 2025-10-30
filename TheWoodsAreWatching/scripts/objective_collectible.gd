extends Area2D

@export var Type = 0

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":
		Global.heldObjectives[Type] = 1
		queue_free()
