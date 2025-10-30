extends Area2D



func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))


func _on_body_entered(body):
	
	if (body.name == "Player"):
		
		var EverythingCollected = true
		
		#transfer global "items held" to "items collected"
		for n in range(3):
			if Global.heldObjectives[n] == 1:
				print("Dropping objective number ", n)
				Global.heldObjectives[n] = 0
				Global.collectedObjectives[n] = 1
			
			#if any objectives are not collected, we do not win
			if Global.collectedObjectives[n] == 0:
				EverythingCollected = false
				
		#if all objectives are collected, win the game (we'll figure out sceneTree stuff later.)
		#Hello, future me, figuring out SceneTree stuff.
		#or maybe hello fellow programmer
		#idk who'll do that
		if EverythingCollected:
			print("You Have Won!!!!!!!!!!!!!!!1!!!11!")
