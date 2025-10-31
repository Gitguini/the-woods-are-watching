extends CharacterBody2D


@export var walkSpeed = 50
@export var runSpeed = 100

var eye

var targetPoint: Vector2 = Vector2.ZERO

func _start():
	eye = $BeastEye

func _physics_process(delta: float) -> void:
	
	#STATE MACHINE RUNDOWN:
	
	
	
	
	
	move_and_slide()

func setTarget(point)->void:
	targetPoint = point

#given a target to move towards and a speed value, generates the velocity vector
#using yCompress
func velocityCalc(speed) -> void:
	
	#1. get a base using the vector directly to the target and our Speed
	var moveVector = (targetPoint - position).normalized()
	
	#2. use trigonometry to reduce via yCompress
	#final magnitude should be equal to: 
	# sqrt(
	# originalXcomponent * cos(angle) 
	# + originalYComponent * sin(angle) * YCompress )
	#... a bit of a costly calculation to be making every frame, no? We'll see.
	var Angle = moveVector.angle()
	var compressionFactor = sqrt(moveVector.x * cos(Angle) + moveVector.y * sin(Angle) * $WorldItemManager.yCompress)
	
	moveVector = moveVector * (compressionFactor * speed)
	
	velocity = moveVector

func SelectPointInRadius(point, r) -> Vector2:
	var xAdd = (randi() % (r*2)) - r
	var yAdd = ((randi() % (r*2)) - r) * $WorldItemManager.yCompress
	return Vector2(point.x + xAdd, point.y + yAdd)
