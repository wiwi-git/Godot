extends Node2D
#  Unit 이라는 타입으로 만들어 변수를 생성하거나 노드를 생성할 때 등에서 Unit 타입으로 생성할 수 있게 된다.
class_name Unit

@export var max_hp: int = 100
@export var damage: int = 10
@export var max_cost: int = 5 # 추가된 코드
@export var unit_name: String = "Hero"

var current_hp: int:
	set(value):
		current_hp = value
		update_ui()
var current_cost: int:
	set(value):
		current_cost = value
		update_ui()

@onready var health_bar = $ProgressBar
@onready var hp_label = $Label
@onready var cost_label = $CostLabel



func _ready():
	current_hp = max_hp
	current_cost = max_cost # 추가된 코드
	if is_in_group("enemy"):
		cost_label.visible = false
	update_ui()

func update_ui():
	if health_bar:
		health_bar.max_value = max_hp
		health_bar.value = current_hp
	if hp_label:
		hp_label.text = "%s: %d/%d" % [unit_name, current_hp, max_hp]
	if cost_label:
		cost_label.text = "%s/%s" % [current_cost, max_cost]


func take_damage(amount: int):
	var temp = current_hp - amount
	current_hp = max(0, temp)

  # 잠깐 빨간색으로 변경
	modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	modulate = Color.WHITE

func heal(amount: int):
	var temp = current_hp + amount
	current_hp = min(temp, max_hp)

func recover_cost():
	if current_cost >= max_cost: return;
	current_cost += 1
