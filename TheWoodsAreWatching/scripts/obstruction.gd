extends StaticBody2D

@export var obstructsVision: bool = true
@export var obstructsMovement: bool = true

@export var type: int = 0
#type list:
#0-2  are Trees (obstructs movement and vision)
#3-5 are Rocks (obstructs movement, not vision)
#6-8 are Bushes (obstructs vision, not movement)

#COLLISION LAYER GUIDE
#layer 1 is Movement. the player, the beast, and all obstructions occupy this layer.
#layer 2 is Vision. The beast eye scans this layer, and the player and all Vision-obstructing objects are on it.

@export var tree1: Texture2D
@export var tree2: Texture2D
@export var tree3: Texture2D
@export var rock1: Texture2D
@export var rock2: Texture2D
@export var rock3: Texture2D
@export var bush1: Texture2D
@export var bush2: Texture2D
@export var bush3: Texture2D

func _ready() -> void:
	
	#set physics layers of object based on whether it obstructs movement and vision
	if type < 3: #trees
		set_collision_layer_value(1, true) #yes movement
		set_collision_layer_value(2, true) #yes vision
	elif type < 6: #rocks
		set_collision_layer_value(1, true) #yes movement
		set_collision_layer_value(2, false) #no vision
	else: #bushes
		set_collision_layer_value(1, false) #no movement
		set_collision_layer_value(2, true) #yes vision
		
	#create the sprite of our obstruction based on its type
	var sprite2d = Sprite2D.new()
	
	
	if type == 0:
		sprite2d.texture = tree1
		sprite2d.scale = Vector2(0.4, 0.4)
		sprite2d.offset = Vector2(0, -350)
	elif type == 1:
		sprite2d.texture = tree2
		sprite2d.scale = Vector2(0.4, 0.4)
		sprite2d.offset = Vector2(0, -350)
	elif type == 2:
		sprite2d.texture = tree3
		sprite2d.scale = Vector2(0.4, 0.4)
		sprite2d.offset = Vector2(0, -350)
	elif type == 3:
		sprite2d.texture = rock1
		sprite2d.scale = Vector2(0.4, 0.4)
		sprite2d.offset = Vector2(0, -150)
	elif type == 4:
		sprite2d.texture = rock2
		sprite2d.scale = Vector2(0.4, 0.4)
		sprite2d.offset = Vector2(0, -150)
	elif type == 5:
		sprite2d.texture = rock3
		sprite2d.scale = Vector2(0.4, 0.4)
		sprite2d.offset = Vector2(0, -150)
	elif type == 6:
		sprite2d.texture = bush1
		sprite2d.scale = Vector2(0.4, 0.4)
		sprite2d.offset = Vector2(0, -150)
	elif type == 7:
		sprite2d.texture = bush2
		sprite2d.scale = Vector2(0.4, 0.4)
		sprite2d.offset = Vector2(0, -150)
	elif type == 8:
		sprite2d.texture = bush3
		sprite2d.scale = Vector2(0.4, 0.4)
		sprite2d.offset = Vector2(0, -150)
	
	add_child(sprite2d)
	
	#set the hitbox to be a size indicated by the hitboxRadius and yCompress
	#I've built a function for determining this into the worldItemManager script
	#w$CollisionShape2D.shape.size.x = $WorldItemManager.getRectHitboxWidth(hitboxRadius)
	#$CollisionShape2D.shape.size.y = $WorldItemManager.getRectHitboxHeight(hitboxRadius)
	
