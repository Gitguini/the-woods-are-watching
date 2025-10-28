extends CanvasLayer

@onready var wood_label = $woodLabel

func _ready():
	wood_label.text = "Wood: %d" % Global.wood
	Global.connect("wood_changed", Callable(self, "_on_wood_changed"))
	
func _on_wood_changed(new_wood):
	wood_label.text = "Wood: %d" % new_wood
