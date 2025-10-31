extends Node

const CAMPFIRE = 0
const AMBIENT = 1
const BEAST = 2

var state

@export var campfireEventEmitter: FmodEventEmitter2D
@export var beastEventEmitter: FmodEventEmitter2D
@export var ambientEventEmitter: FmodEventEmitter2D

func _ready()->void:
	
	#play campfire event
	state = CAMPFIRE
	

func _on_leave_campfire()->void:
	if (state == CAMPFIRE):
		#stop campfire event
		campfireEventEmitter.stop()
		#start amient event
		ambientEventEmitter.play()
		state = AMBIENT

func _on_enter_campfire()->void:
	if (state == AMBIENT):
		#stop ambient event
		ambientEventEmitter.stop()
		#start campfire event
		campfireEventEmitter.play()
		state = CAMPFIRE

func _on_chase_start()->void:
	if (state == AMBIENT):
		#stop ambient event
		ambientEventEmitter.stop()
		#start beast event
		beastEventEmitter.play()
		state = BEAST

func _on_beast_scare()->void:
	if (state==BEAST):
		#stop beast event
		beastEventEmitter.stop()
		#start campfire event
		campfireEventEmitter.play()
		state = CAMPFIRE
