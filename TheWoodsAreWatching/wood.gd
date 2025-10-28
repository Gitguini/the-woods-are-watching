extends Area2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	
	
func _on_body_entered(body):
	if body.name == "Player":
		Global.wood += 1
		Global.emit_signal("wood_changed", Global.wood)
		queue_free()
