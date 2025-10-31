extends Area2D

@export var tex0: Texture2D
@export var tex1: Texture2D
@export var tex2: Texture2D
@export var tex3: Texture2D

@export var type: int

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	
	var sprite2d = Sprite2D.new()
	
	
	if type == 0:
		sprite2d.texture = tex0
		sprite2d.scale = Vector2(0.125, 0.125)
		sprite2d.offset = Vector2(0, -100)
	elif type == 1:
		sprite2d.texture = tex1
		sprite2d.scale = Vector2(0.125, 0.125)
		sprite2d.offset = Vector2(0, -100)
	elif type == 2:
		sprite2d.texture = tex2
		sprite2d.scale = Vector2(0.125, 0.125)
		sprite2d.offset = Vector2(0, -100)
	elif type == 3:
		sprite2d.texture = tex3
		sprite2d.scale = Vector2(0.125, 0.125)
		sprite2d.offset = Vector2(0, -100)
	
	add_child(sprite2d)
	
	
func _on_body_entered(body):
	if body.name == "Player":
		Global.wood += 1
		Global.emit_signal("wood_changed", Global.wood)
		queue_free()
