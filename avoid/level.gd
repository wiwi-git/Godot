extends Node2D

@export var fireball_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var fireball = fireball_scene.instantiate()
	fireball.position = Vector2(randf_range(-500, 500), -500)
	add_child(fireball)
