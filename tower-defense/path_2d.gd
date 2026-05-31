extends Path2D

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 1.0

var timer: float = 0.0
var start_count: int = 5

@onready var counter_label = $"../TowerMenu/CenterLabel"

#true로 설정하면 처리가 활성화됩니다. 노드가 처리 중일 때는 매 프레임마다 NOTIFICATION_PROCESS 알림을 받게 되며, _process() 콜백 함수가 있는 경우 해당 함수가 호출됩니다.
#참고: _process() 함수가 재정의된 경우, _ready() 함수가 호출되기 전에 자동으로 처리가 활성화됩니다.
func _ready() -> void:
	set_process(false)

func _process(delta):
	timer += delta
	if timer >= spawn_interval:
		spawn_enemy()
		timer = 0.0

func spawn_enemy():
	if enemy_scene:
		var new_enemy = enemy_scene.instantiate()
		add_child(new_enemy)

func _on_timer_timeout() -> void:
	start_count -= 1
	counter_label.text = str(start_count)
	if start_count <= 0:
		$Timer.stop()
		counter_label.text = ""
		set_process(true)
