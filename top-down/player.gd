extends Area2D

@export var speed: int = 200
@export var team: StringName
@export var health: int = 3:
	set(value):
		health = value
		$HUD.set_life(value)


@onready var basic_offset: Vector2 = $Hitbox/CollisionShape2D.position

var is_attacking: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if not is_attacking:
		var dir = Input.get_vector("left", "right", "up", "down")
		position += dir * speed * delta

		if dir.x < 0:
			$AnimatedSprite2D.flip_h = true
			$Hitbox/CollisionShape2D.position = Vector2(-basic_offset.x, basic_offset.y)
			#$Hitbox.position = Vector2(-basic_offset.x, basic_offset.y)
		elif dir.x > 0:
			$AnimatedSprite2D.flip_h = false
			$Hitbox/CollisionShape2D.position = basic_offset
			#$Hitbox.position = basic_offset
			

		if dir != Vector2.ZERO:
			$AnimatedSprite2D.play("move")
		else:
			$AnimatedSprite2D.play("idle")

		if Input.is_action_just_pressed("attack"):
			attack()
			

func take_damage(damage: int) -> void:
	print("player - take_damage:",damage)
	health -= damage
	if health <= 0:
		queue_free()
		
func attack() -> void:
	is_attacking = true
	$AnimatedSprite2D.play("attack")
	$Hitbox.enable()
	await get_tree().create_timer(0.35).timeout
	$Hitbox.disable()
	is_attacking = false
