extends CanvasLayer

@onready var container: HBoxContainer = $HBoxContainer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_life(life: int) -> void:
	for node in container.get_children():
		node.hide()
	for i in life:
		container.get_child(i).show() 
