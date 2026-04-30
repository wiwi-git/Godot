extends Area2D


@export var health: int = 3
@export var team: StringName
@export var bullet: PackedScene

@onready var player: Node2D = get_tree().get_first_node_in_group("player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		queue_free()


func _on_timer_timeout() -> void:
	if not player : return
	
	var obj = bullet.instantiate()
	add_sibling(obj)
	obj.global_position = global_position
	obj.rotation = global_position.direction_to(player.global_position).angle()
