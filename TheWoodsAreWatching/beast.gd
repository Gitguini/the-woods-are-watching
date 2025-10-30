extends CharacterBody2D


@export var walkSpeed = 50
@export var runSpeed = 100

var eye

var targetPoint: Vector2 = Vector2.ZERO

func _start():
	eye = $BeastEye

func _physics_process(delta: float) -> void:
	
	
	
	move_and_slide()

#given a target to move towards and a speed value, generates the velocity vector
#using yCompress
func velocityCalc(speed) -> void:
	
	#1. get a base using the vector directly to the target and our Speed
	var moveVector = (targetPoint - position).normalized() * speed 
	
	#2. use trigonometry to reduce via yCompress
	#final magnitude should be equal to: 
	# sqrt(
	# originalXcomponent * cos(angle) 
	# + originalYComponent * sin(angle) * YCompress )
	#... a bit of a costly calculation to be making every frame, no? We'll see.
	
	
	
	velocity = moveVector
