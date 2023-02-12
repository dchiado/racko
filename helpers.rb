require 'io/console'                                                                                                       

def shuffle_deck(cards = nil)
    cards ? cards.shuffle : (1..60).to_a.shuffle
end

def deal_cards
    hand = @deck.take(10)
    @deck.shift(10)
    return hand
end

def display_hand
    puts
    puts "Current hand:"
    @hand.each_with_index do |card, idx|
        puts "--"
        puts "[#{card}]"
    end
    puts
end

def draw_card
    if @deck.empty?
        puts "Shuffling discard pile"
        @deck = shuffle_deck(@discard)
        @discard.clear
    end

    card = @deck.take(1)[0]
    @deck.shift(1)
    @turns += 1
    puts "Card drawn: [#{card}]"
    return card
end

def ask_to_draw  
    print "Press any key to draw a card"                                                                                                    
    STDIN.getch
    puts
    draw_card                                                                                                     
end

def you_win
    puts "You win! It took you #{@turns} turns."
    @game_won = true
end

def choose_where_to_place_card(new_card)
    turn_completed = false
    until turn_completed
        puts "Enter the card you'd like to replace, 'd' to discard the [#{new_card}], or 'q' to quit"
        response = gets.chomp
        if response == 'd'
            @discard.push(new_card) 
            turn_completed = true
        elsif response == 'q'
            puts "Lame..."
            exit
        elsif @hand.include?(response.to_i)
            card_to_replace = response.to_i
            @hand[@hand.index(card_to_replace)] = new_card
            @discard.push(card_to_replace)
            turn_completed = true
        else
            puts "That card is not in your hand"
        end
        you_win if @hand == @hand.sort.reverse
    end
end