extends CharacterBody2D

@export var speed = 200

@export var basePointX = 0
@export var basePointY = 0
@export var colRadius = 0

var compressor

var collisionThing

func _ready() -> void:
	compressor = $WorldItemManager
	collisionThing = $CollisionShape2D
	
	collisionThing.position.x = basePointX
	collisionThing.position.y = basePointY
	collisionThing.shape.radius = colRadius
	
	

func _physics_process(delta: float) -> void:
	var moveDir = Vector2.ZERO
	
	moveDir.x = Input.get_axis("move_left", "move_right")
	moveDir.y = Input.get_axis("move_up", "move_down")
	
	if moveDir.length() > 0:
		moveDir = moveDir.normalized()
		moveDir.y = moveDir.y * compressor.yCompress
	
	velocity = moveDir * speed
	
	move_and_slide()
