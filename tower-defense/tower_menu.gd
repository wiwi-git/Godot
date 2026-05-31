extends CanvasLayer

var current_tower = null

func _process(delta: float) -> void:
  # current_tower에 무언가 들어있고, place_tower 입력을 했으면
	if Input.is_action_just_pressed("place_tower") and is_instance_valid(current_tower):
		var tower = current_tower.instantiate()
	# 최상위(루트) 노드의 자식으로 추가
		get_tree().root.add_child(tower)
	# 뷰포트 불러오기->카메라 불러오기->마우스 위치 불러오기
		tower.position = get_viewport().get_camera_2d().get_global_mouse_position()
	# 타워 소환했으니 선택 해제해주기
		current_tower = null
		
func _on_button_pressed() -> void:
	if GoldManager.money >= 50 and not is_instance_valid(current_tower):
		current_tower = preload("res://tower.tscn")
		GoldManager.money -= 50
		
func _ready() -> void:
	$CenterLabel.text = ""
	$Money.text = str(GoldManager.money) # 초기 자금으로 설정하기
	
	GoldManager.money_changed.connect(money_update)

func money_update(new_money: int) -> void:
	$Money.text = str(new_money)
