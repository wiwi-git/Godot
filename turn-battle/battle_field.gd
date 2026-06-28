extends Node2D

class_name BattleField

# 현재 전투 상태
enum BattleState { PLAYER_TURN, ENEMY_TURN, WON, LOST }

@export var player: Unit
@export var enemy: Unit
@export var info_label: Label
@export var card_container: Control
@export var pass_button: Button

@export var deck: Array[Card] # 사용 가능한 카드들
@export var card_ui_scene: PackedScene # 카드 ui 씬


var current_state: BattleState = BattleState.PLAYER_TURN


func _ready():
	update_info("전투 시작! 플레이어의 턴.")
	start_player_turn() # 함수 변경

func start_player_turn():
	pass_button.visible = true
	
	current_state = BattleState.PLAYER_TURN
	update_info("Your Turn: Pick a card!")
	draw_hand()

#func check_turn():
	#if current_state == BattleState.PLAYER_TURN:
		#action_buttons.visible = true
		#update_info("플레이어의 턴: 행동을 선택하세요.")
	#elif current_state == BattleState.ENEMY_TURN:
		#action_buttons.visible = false
		#update_info("적이 생각하고 있습니다...")
		#await get_tree().create_timer(1.0).timeout
		#enemy_attack()

func draw_hand():
	# 기존의 카드 제거
	for child in card_container.get_children():
		child.queue_free()

	# 카드 3개 랜덤으로 불러오기
	for i in range(3):
		var random_card_data = deck.pick_random()

		var new_card_ui = card_ui_scene.instantiate()
		card_container.add_child(new_card_ui)

		# 카드 값 설정, 시그널 연결
		new_card_ui.set_card(random_card_data)
		new_card_ui.card_selected.connect(_on_card_played)
		
	#player.current_cost += 1 # 추가된 코드. 매 턴 1코스트를 추가해준다
	player.recover_cost()

# 카드를 사용했을 때 사용 처리를 해주는 함수
func _on_card_played(card: Card):
	if current_state != BattleState.PLAYER_TURN: return
	if player.current_cost < card.cost: return # 추가된 코드
	
	if card.damage > 0:
		enemy.take_damage(card.damage)
		update_info("%s 사용! %d 피해를 가함." % [card.card_name, card.damage])

	if card.heal > 0:
		player.heal(card.heal)
		update_info("%s 사용! %d 만큼 회복함." % [card.card_name, card.heal])
		
	player.current_cost -= card.cost # 추가된 코드
	
	# 카드 모두 삭제
	for child in card_container.get_children():
		child.queue_free()

	end_player_turn()

func update_info(text: String):
	info_label.text = text
	
	
# AttackButton의 pressed 시그널에 연결
#func _on_attack_button_pressed():
	#if current_state != BattleState.PLAYER_TURN: return
#
	#enemy.take_damage(player.damage)
	#update_info("공격해서 %d 만큼의 피해를 입힘!" % player.damage)
#
	#end_player_turn()
#
## HealButton의 pressed 시그널에 연결
#func _on_heal_button_pressed():
	#if current_state != BattleState.PLAYER_TURN: return
#
	#player.heal(20)
	#update_info("체력을 20 만큼 회복함!")
#
	#end_player_turn()

func end_player_turn():
	#action_buttons.visible = false
	
	if enemy.current_hp <= 0:
		current_state = BattleState.WON
		end_battle()
	else:
		current_state = BattleState.ENEMY_TURN
		await get_tree().create_timer(1.0).timeout
		enemy_turn()
		
func enemy_turn():
	pass_button.visible = false
	
	player.take_damage(enemy.damage)
	update_info("적이 %d 만큼의 피해를 입힘!" % enemy.damage)

	if player.current_hp <= 0:
		current_state = BattleState.LOST
		update_info("패배...")
	else:
		await get_tree().create_timer(1.0).timeout
		start_player_turn()
	
#func enemy_attack():
	#player.take_damage(enemy.damage)
	#update_info("Enemy attacked you for %d damage!" % enemy.damage)
#
	#if player.current_hp <= 0:
		#current_state = BattleState.LOST
		#end_battle()
	#else:
		#current_state = BattleState.PLAYER_TURN
		#await get_tree().create_timer(1.0).timeout
		#check_turn()

func end_battle():
	#action_buttons.visible = false
	if current_state == BattleState.WON:
		update_info("VICTORY! The enemy falls.")
	elif current_state == BattleState.LOST:
		update_info("DEFEAT... You have fallen.")
 

func _on_pass_button_pressed() -> void:
	if current_state != BattleState.PLAYER_TURN: return
	enemy_turn()
