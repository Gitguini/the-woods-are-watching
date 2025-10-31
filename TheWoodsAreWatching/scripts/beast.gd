extends CharacterBody2D

signal caughtYou
signal chaseStart
signal fearStart


@export var Player: Node2D

@export var stalkSpeed = 100
@export var walkSpeed = 200
@export var runSpeed = 400

@export var wanderingRadius = 2500
@export var soundRadius = 1000

@onready var animated_sprite_2D: AnimatedSprite2D = $AnimatedSprite2D

var State = -1

const WANDER = 0
const SNIFF = 1
const CHASE = 2
const FEAR = 3

var eye

var targetPoint: Vector2 = Vector2.ZERO

func _ready():
	eye = $BeastEye
	targetPoint = SelectPointInRadius(Player.position, wanderingRadius)
	Global.connect("pickup_noise", Callable(self, "_on_noise_heard"))

func _physics_process(delta: float) -> void:
	
	match State:
		WANDER:
			#print("Wander")
			#Wandering mode
			#Every frame, have a small chance to pick a new target point.
			#This point is within some distance of the player.
			#Walk towards it at walking speed.
			#Check your eyes each frame for the player, if you see her, CHASE.
			
			if(randf() < 0.005):
				targetPoint = SelectPointInRadius(Player.position, wanderingRadius)
			
			velocityCalc(walkSpeed)
			
			if $BeastEye.lookForPoint(Player.position):
				chaseStart.emit()
				State = CHASE
			
			pass
		SNIFF:
			#print("sniff")
			#Upon hearing nearby object
			#Stalk towards position. If there, stand still for a few seconds. Keep checking for player with eyes.
			#Return to wander if nothing found.
			
			velocityCalc(stalkSpeed)
			
			if $BeastEye.lookForPoint(Player.position):
				chaseStart.emit()
				State = CHASE
			
			pass
		CHASE:
			#print("Chase")
			#Make a beeline for the player
			#Check your eyes. Keep a timer of how long it's been since youve seen her.
			#If you lose track for more than 5 seconds, return to wandering.
			targetPoint = Player.position
			velocityCalc(runSpeed)
			pass
		FEAR:
			#dsprint("Fear")
			#Ur silly ass walked into the fire.
			#start up a timer. Pick a completely random spot near the edge of the map
			#and make a beeline. Don't stop until the timer is done.
			#Then return to wandering.
			
			velocityCalc(runSpeed)
			
			pass
	
	setSprite()
	setEyeRotation()
	move_and_slide()

func setTarget(point)->void:
	targetPoint = point

#given a target to move towards and a speed value, generates the velocity vector
#using yCompress
func velocityCalc(speed) -> void:
	
	if (position.distance_to(targetPoint) < 10):
		velocity = Vector2.ZERO
		return
	
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

func setSprite()->void:
	
	if velocity.length() < 1:
		return
	
	#for directions, we can compare x and y components of movement
	#if abs(y) is greater than abs(x), then we use y component to decide direction (up or down)
	
	var moveDir = 0;
	var RIGHT = 0
	var UP = 1
	var LEFT = 2
	var DOWN = 3
	#0=right, 1=up, 2=left, 3=down
	
	#1. determine direction
	if (abs(velocity.y) >= abs(velocity.x)): #vertical movement
		if (velocity.y >= 0):
			moveDir = DOWN
		else:
			moveDir = UP
	else: #horizontal movement
		if (velocity.x >= 0):
			moveDir = RIGHT
		else:
			moveDir = LEFT
	
	#2. for each direction, use current state to set sprite
	
	if moveDir == RIGHT:
		if State == CHASE:
			animated_sprite_2D.animation = "chaseRight"
		elif State == WANDER:
			animated_sprite_2D.animation = "walkRight"
		elif State == SNIFF:
			animated_sprite_2D.animation = "stalkRight"
		elif State == FEAR:
			animated_sprite_2D.animation = "stalkRight"
	elif moveDir == LEFT:
		if State == CHASE:
			animated_sprite_2D.animation = "chaseLeft"
		elif State == WANDER:
			animated_sprite_2D.animation = "walkLeft"
		elif State == SNIFF:
			animated_sprite_2D.animation = "stalkLeft"
		elif State == FEAR:
			animated_sprite_2D.animation = "stalkLeft"
	elif moveDir == UP:
		if State == CHASE:
			animated_sprite_2D.animation = "chaseUp"
		elif State == WANDER:
			animated_sprite_2D.animation = "walkUp"
		elif State == SNIFF:
			animated_sprite_2D.animation = "stalkUp"
		elif State == FEAR:
			animated_sprite_2D.animation = "stalkUp"
	else:
		if State == CHASE:
			animated_sprite_2D.animation = "chaseDown"
		elif State == WANDER:
			animated_sprite_2D.animation = "walkDown"
		elif State == SNIFF:
			animated_sprite_2D.animation = "stalkDown"
		elif State == FEAR:
			animated_sprite_2D.animation = "stalkDown"

func SelectPointInRadius(point, r) -> Vector2:
	var xAdd = (randi() % (r*2)) - r
	var yAdd = ((randi() % (r*2)) - r) * $WorldItemManager.yCompress
	return Vector2(point.x + xAdd, point.y + yAdd)

func setEyeRotation() -> void:
	
	if velocity.length() < 1:
		return
	
	#set the eye to face the same direction as velocity
	#this one really sucks
	var velAngle = velocity.angle()
	var eyeAngle = $BeastEye.transform.get_rotation()
	
	var angleDifference = velAngle - eyeAngle
	
	$BeastEye.transform = $BeastEye.transform.rotated(angleDifference)
	
	

func _on_noise_heard(origin) -> void:
	if (State == WANDER or State == SNIFF) and position.distance_to(origin) < soundRadius:
		State = SNIFF
		targetPoint = origin
		$SniffTimer.start()


func _on_sniff_timer_timeout() -> void:
	if (State == SNIFF):
		State = WANDER


func _on_fear_timer_timeout() -> void:
	State = WANDER


func _on_chase_attention_span_timer_timeout() -> void:
	if State != FEAR:
		State = WANDER


func _on_startup_timer_timeout() -> void:
	State = WANDER


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		caughtYou.emit()


func _on_fire_beast_enter() -> void:
		State = FEAR
		fearStart.emit()
		$FearTimer.start()
		targetPoint = Vector2(randi() % 30000 - 15000, randi() % 15000 - 7500)
