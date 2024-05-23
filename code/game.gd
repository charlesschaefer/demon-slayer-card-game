extends Node2D

const TARGET_CARDS = 1
const CARDS_ON_GRID = 6
const DEBUG = false

var challenge_card_number = 0
var deck_array = []
var possible_cards = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# starts listening the click event
	listen_cards_clicks()
	start_card_deck()
#	pass # Replace with function body.


func start_card_deck():
	set_challenge_card()
	deck_array = []
	possible_cards = []
	build_card_deck()
	deck_array.shuffle()
	display_card_deck()
	

func set_challenge_card():
	challenge_card_number = randi_range(1, 6)
	var challenge_card = get_node("ChallengeCard")
	challenge_card.show_character(challenge_card_number)


# adiciona no deck as cartas que já deveriam estar 
func build_card_deck():
	for i in range(TARGET_CARDS):
		deck_array.append(challenge_card_number)

	# agora montamos um array apenas com as cartas possíveis de serem 
	# adicionadas no grid após a adição da target
	var cards = get_node("GridContainer").get_children()
	
	for card in cards:
		if card.name != "Card-" + str(challenge_card_number):
			possible_cards.append(card.name.replace('Card-', '').to_int())
	
	var possible_total = CARDS_ON_GRID - TARGET_CARDS
	# adiciona as cartas no deck, mesmo que sejam repetidas
	for i in range(possible_total):
		var idx = randi_range(0, possible_total -1)
		deck_array.append(possible_cards[idx])
	

func display_card_deck():
	var total_cards = deck_array.size()
	var cards = get_node("GridContainer").get_children()
	#var char_num = ""
	for idx in range(total_cards):
		cards[idx].show_character(deck_array[idx])


func listen_cards_clicks():
	for card in get_node("GridContainer").get_children():
		card.card_clicked.connect(_on_card_clicked)

func _on_card_clicked(card, character):
	if (character == challenge_card_number):
		print("Boa", character, challenge_card_number)
		card.visible = true
		# start after winning
		start_card_deck()
	else:
		print("burra", character, challenge_card_number)
		card.visible = false
	get_node("GridContainer/Card-1")
