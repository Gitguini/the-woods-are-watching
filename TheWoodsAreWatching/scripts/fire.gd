extends Area2D

@export var initialBurnTime = 30
@export var woodBonus = 30
@export var fearRadiusBase = 100
@export var fearRadiusMultiplier = 3

@export var lightStrengthBase = 1
@export var lightMultiplier = 1

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
		fireLight.texture_scale = lightStrengthBase + burnTimer * lightMultiplier
	else:
		fireLight.texture_scale = 0.0
		ableToReceiveFuel = false

func _on_body_entered(body):
	
	if (body.name == "Player") and ableToReceiveFuel and Global.wood > 0:
		burnTimer += woodBonus * Global.wood
		Global.wood = 0
		Global.emit_signal("wood_changed", 0)
		
