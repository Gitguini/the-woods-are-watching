extends Area2D

@export var type = 0

@export var tex1: Texture2D
@export var tex2: Texture2D
@export var tex3: Texture2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	
	#var sprite2d = Sprite2D.new()
	#add_child(sprite2d)
	
	#if type == 0:
		#print("I'm type 1!!")
		#sprite2d.texture = tex1
	#elif type == 1:
		#sprite2d.texture = tex2
	#elif type == 2:
		#sprite2d.texture = tex3

	
	#sprite2d.scale = Vector2(0.125, 0.125)
	#sprite2d.offset = Vector2(0, -350)
	



func _on_body_entered(body):
	if body.name == "Player":
		Global.heldObjectives[type] = 1
		queue_free()
