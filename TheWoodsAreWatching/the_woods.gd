extends Node2D

@export var obstructionScene: PackedScene
@export var woodScene: PackedScene
@export var numberOfObstructions: int
@export var numberOfWoods: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for n in range(numberOfObstructions):
		var newObstruction = obstructionScene.instantiate()
		newObstruction.type = randi() % 9
		newObstruction.position = getSpawnPos()
		add_child(newObstruction)
	
	for n in range(numberOfWoods):
		var newWood = woodScene.instantiate()
		newWood.type = randi() % 4
		newWood.position = getSpawnPos()
		add_child(newWood)


func getSpawnPos()->Vector2:
	
	var x = (randi() % 9012) - 4096
	var y = (randi() % 4096) - 2048
	
	while (x > -500 and x < 500) and (y > -500 and y < 500):
		x = (randi() % 9012) - 4096
		y = (randi() % 4096) - 2048
	
	return Vector2(x, y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
