extends Button
class_name CardUI

signal card_selected(card_data: Card)

var my_card_data: Card

func set_card(card: Card):
	my_card_data = card
	#text = card.card_name + "\n" + card.description
	text = card.card_name + ": " + str(card.cost) + "\n" + card.description

# Button의 pressed 시그널에 연결
func _on_pressed():
	card_selected.emit(my_card_data)
