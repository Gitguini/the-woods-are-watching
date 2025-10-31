extends Area2D

signal playerEnter
signal beastEnter
signal playerExit


@export var initialBurnTime = 30
@export var woodBonus = 30
@export var fearRadiusBase = 100
@export var fearRadiusMultiplier = 3

@export var lightStrengthBase = 2
@export var lightStrengthCap = 20
@export var lightMultiplier = 0.25

var ableToReceiveFuel: bool


var collisionThing
var compressor
var burnTimer: float
var fireLight


func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	
	collisionThing = $FireCollider
	compressor = $WorldItemManager
	burnTimer = initialBurnTime
	fireLight = $PointLight2D
	ableToReceiveFuel = true



func _process(delta: float) -> void:
	
	if burnTimer > 0:
		burnTimer -= delta
	
	
	
	if burnTimer > 0:
		#TODO: add light flickering effect where something gets added to this based on a sin/noise function of Time
		fireLight.texture_scale = clamp(lightStrengthBase + lightMultiplier*burnTimer, 0, lightStrengthCap)
	else:
		fireLight.texture_scale = 0.0
		ableToReceiveFuel = false
		queue_free()

func _on_body_entered(body):
	
	if (body.name == "Player") and ableToReceiveFuel and Global.wood > 0:
		burnTimer += woodBonus * Global.wood
		Global.wood = 0
		Global.emit_signal("wood_changed", 0)
		


func _on_fear_radius_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		playerEnter.emit()
	elif body.name == "Beast":
		beastEnter.emit()


func _on_fear_radius_body_exited(body: Node2D) -> void:
	if (body.name == "Player"):
		playerExit.emit()
