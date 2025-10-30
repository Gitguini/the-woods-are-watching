extends Node

var yCompress = 0.75

func _ready() -> void:
	pass # Replace with function body.
	

#Gets distance between 2 points, adjusted using yCompress (treats the y component as compressed)
#to do this, we get the vector between the 2 points and then multiply the y component by the INVERSE of yCompress
#stretching it to its "actual" distance.
func getAdjustedDistance(origin, destination) -> Vector2:
	var unadjustedDifference = origin - destination
	unadjustedDifference.y = unadjustedDifference.y * (1.0 / yCompress)
	return unadjustedDifference.magnitude

#used to set up a hitbox. Given some radius we will create a capsule with a proportionate Height and Radius value.
func getCapsuleHitboxHeight(radius) -> float:
	return radius * 2

#TODO second part of the above process.
func getCapsuleHitboxRadius(radius) -> float:
	return -1.0
	
func getRectHitboxHeight(radius) -> float:
	return radius * 2 * yCompress
	
func getRectHitboxWidth(radius) -> float:
	return radius * 2
	
