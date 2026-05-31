extends PathFollow2D

@export var speed = 150
@export var health: float = 10
@export var drop_money = 5 # 추가된 코드

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * speed
	
	if progress_ratio >= 1.0:
		print("goal")
		queue_free()
		
func take_damage(amount: float):
	health -= amount
	if health <= 0:
		GoldManager.money += drop_money # 추가된 코드
		queue_free()
	
