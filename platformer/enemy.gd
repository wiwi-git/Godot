extends CharacterBody2D


@export var SPEED = 50
var target: Node2D = null


func _physics_process(delta: float) -> void:
	if not target:
		return
	var dir = sign(target.global_position.x - global_position.x)
	velocity.x = dir * SPEED
	if dir != 0:
		$AnimatedSprite2D.flip_h = dir < 0
	move_and_slide()
	
	for i in get_slide_collision_count():
		var col = get_slide_collision(i).get_collider()
		if col.is_in_group("player"):
			get_tree().reload_current_scene()


func _on_player_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		target = body


func _on_player_detector_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		target = null
