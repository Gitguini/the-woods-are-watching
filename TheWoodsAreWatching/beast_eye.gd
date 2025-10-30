extends Node2D

@export var sightRadius = 800
@export var sightSpread = 45

var compressor

func _start():
	compressor = $WorldItemManager

#this method tells whether the player is visible.
#the player is visible if the following 3 things are true:
#1. the player is within a distance of sightRadius (adjusted with yCompress)
#2. the player is within an angle of sightSpread from the eye's current direction
#3. there are no sight-blocking objects between this eye and the player
func lookForPlayer() -> bool:
	#test 1: within sight radius
	
	#test 2: within angle of sightSpread
	#useful for this: maintain a forward-vector (or makeone up here) and use
	#Vector2.angleToPoint
	
	#test 3
	#use rayCast2D for this
	
	return true
