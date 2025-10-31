extends Node2D

@export var sightRadius = 800
@export var sightSpread = 0.5

var compressor

func _start():
	compressor = $WorldItemManager

#this method tells whether the player is visible.
#the player is visible if the following 3 things are true:
#1. the player is within a distance of sightRadius (adjusted with yCompress)
#2. the player is within an angle of sightSpread from the eye's current direction
#3. there are no sight-blocking objects between this eye and the player
func lookForPoint(point) -> bool:
	#test 1: within sight radiuas
	if global_position.distance_to(point) > sightRadius:
		return false
	
	#test 2: within angle of sightSpread
	var forwardAngle = transform.get_rotation();
	var angleToPlayer = global_position.angle_to_point(point)
	if (abs(forwardAngle - angleToPlayer) > sightSpread):
		return false
	
	#test 3: obstruction
	#use rayCast2D for this
	$RayCast2D.target_position = to_local(point)
	#^findin that to_local() function was a pain in the ass
	#im not even sure why it works but it works
	#actually i get it, the problem was that it was taking in the Global position of the player
	#and setting the target position, Relative To The Eye
	#so by first translating the player's position to 'position relative to the eye', all is good
	$RayCast2D.force_raycast_update()
	var obstructingObject = $RayCast2D.get_collider()
	if (obstructingObject == null):
		return false
	elif (obstructingObject.name != "Player"):
		return false
	
	return true
