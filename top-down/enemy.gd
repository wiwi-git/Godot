extends Area2D


@export var health: int = 1
@export var team: StringName
@export var speed: int = 50

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: Node2D = get_tree().get_first_node_in_group("player")
@onready var basic_offset: Vector2 = $Hitbox/CollisionShape2D.position
@onready var hitbox_coll: CollisionShape2D = $Hitbox/CollisionShape2D

var is_attacking: bool = false


func _process(delta: float) -> void:
	if not is_attacking and player:
		var dir := position.direction_to(player.position)
		position += dir * speed * delta
		if dir.x < 0:
			sprite.flip_h = true
			hitbox_coll.position = Vector2(-basic_offset.x, basic_offset.y)
			#$Hitbox.position = Vector2(-basic_offset.x, basic_offset.y)
		elif dir.x > 0:
			sprite.flip_h = false
			hitbox_coll.position = basic_offset
			#$Hitbox.position = basic_offset
			
		if dir != Vector2.ZERO: sprite.play("move")
		else: sprite.play("idle")

		if position.distance_to(player.position) <= 10:
			attack()


func take_damage(damage: int) -> void:
	print("enemy - take_damage:",damage)
	health -= damage
	if health <= 0:
		queue_free()


func attack() -> void:
	is_attacking = true
	sprite.play("idle")
	await get_tree().create_timer(0.4).timeout
	sprite.play("attack")
	$Hitbox.enable()
	await get_tree().create_timer(0.35).timeout
	$Hitbox.disable()
	is_attacking = false
