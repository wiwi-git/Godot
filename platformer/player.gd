extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0

@onready var hud: CanvasLayer = $Hud
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var jump_sound: AudioStream

var score: int:
	set(new_value):
		score = new_value
		hud.set_score_text(score)


func _play_animation(direction: float) -> void:
	if direction != 0:
		anim_sprite.flip_h = direction < 0
	if not is_on_floor():
		anim_sprite.play("jump")
	else:
		if direction == 0:
			anim_sprite.play("idle")	
		else:
			anim_sprite.play("walk")


func _physics_process(delta: float) -> void:	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var dir := Input.get_axis("ui_left","ui_right")
	_play_animation(dir)
	
	velocity.x = dir * SPEED
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		SoundManager.play_sfx(jump_sound)
	
	move_and_slide()
