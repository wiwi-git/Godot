extends Area2D

var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta
	if position.y > get_viewport_rect().size.y + 100:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	#print("_on_area_entered")
	if area.is_in_group("player"):
		get_tree().reload_current_scene()
