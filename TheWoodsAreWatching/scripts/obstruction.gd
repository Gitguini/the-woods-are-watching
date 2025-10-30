extends StaticBody2D

@export var obstructsVision: bool = true
@export var obstructsMovement: bool = true

@export var hitboxRadius: int = 300


func _ready() -> void:
	
	#TODO set physics layers of object based on whether it obstructs movement and vision
	
	#set the hitbox to be a size indicated by the hitboxRadius and yCompress
	#I've built a function for determining this into the worldItemManager script
	#w$CollisionShape2D.shape.size.x = $WorldItemManager.getRectHitboxWidth(hitboxRadius)
	#$CollisionShape2D.shape.size.y = $WorldItemManager.getRectHitboxHeight(hitboxRadius)
	pass
	
