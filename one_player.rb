require './helpers.rb'

@deck = shuffle_deck
@hand = deal_cards
@discard = []
@turns = 0
@game_won = false

until @game_won
    display_hand
    new_card = ask_to_draw
    choose_where_to_place_card(new_card)
end