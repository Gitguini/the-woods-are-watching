extends CharacterBody2D

@export var speed = 200

@export var colRadius = 0

@onready var animated_sprite_2D: AnimatedSprite2D = $AnimatedSprite2D

var compressor

var collisionThing

func _ready() -> void:
	compressor = $WorldItemManager
	collisionThing = $CollisionShape2D
	
	collisionThing.shape.radius = colRadius
	
	

func _physics_process(delta: float) -> void:
	var moveDir = Vector2.ZERO
	
	moveDir.x = Input.get_axis("move_left", "move_right")
	moveDir.y = Input.get_axis("move_up", "move_down")
	
	if (moveDir.x < 0 && moveDir.y == 0):
		animated_sprite_2D.animation = "left"
	
	if (moveDir.x > 0 && moveDir.y == 0):
		animated_sprite_2D.animation = "right"
	
	if (moveDir.y < 0):
		animated_sprite_2D.animation = "up"
	
	if (moveDir.y > 0):
		animated_sprite_2D.animation = "down"
	
	if moveDir.length() > 0:
		moveDir = moveDir.normalized()
		moveDir.y = moveDir.y * compressor.yCompress
	
	
	velocity = moveDir * speed
	
	move_and_slide()
	
