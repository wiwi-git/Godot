extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0

@onready var hud: CanvasLayer = $Hud
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer = $AudioStreamPlayer

var score: int:
	set(new_value):
		score = new_value
		hud.set_score_text(score)
		print('new score: ' + str(score))
		

func _physics_process(delta: float) -> void:	

	var dir := Input.get_axis("ui_left","ui_right")
	
	if dir != 0:
		anim_sprite.flip_h = dir < 0
	if not is_on_floor():
		velocity += get_gravity() * delta
		anim_sprite.play("jump")
	else:
		if dir == 0:
			anim_sprite.play("idle")	
		else:
			anim_sprite.play("walk")
	
	velocity.x = dir * SPEED
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()
	
	move_and_slide()
