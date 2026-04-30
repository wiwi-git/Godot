extends Area2D

@export var damage: int = 1
@export var team: StringName

@onready var col_shape: CollisionShape2D = $CollisionShape2D

func enable() -> void:
	col_shape.set_deferred("disabled", false)

func disable() -> void:
	col_shape.set_deferred("disabled", true)


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage") and area.team != team:
		area.take_damage(damage)
