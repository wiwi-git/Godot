extends Area2D

@export var bullet_scene: PackedScene

var can_shoot = true
var enemy_list: Array[Node2D] = []

func _process(delta: float) -> void:
	if enemy_list.is_empty(): return
	
	var target = enemy_list[0]
	if not is_instance_valid(target): 
		enemy_list.erase(target)
		return
	
	look_at(target.global_position)
	if can_shoot: shoot()
		


func shoot() -> void:
	can_shoot = false
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation
	$Timer.start()
	
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		var enemy = area.get_parent()
		enemy_list.append(enemy)


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		var enemy = area.get_parent()
		enemy_list.erase(enemy)


func _on_timer_timeout() -> void:
	can_shoot = true
