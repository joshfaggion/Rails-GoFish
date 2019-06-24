class Deck
  attr_reader :cards
  def initialize(cards = [])
    if cards.length == 0
      @cards=[]
      ranks=%w[a 2 3 4 5 6 7 8 9 10 j q k]
      suits=%w[h s d c]
      suits.each do |suit|
        ranks.each do |rank|
          card = Card.new(rank: rank, suit: suit)
          @cards.push(card)
        end
      end
    else
      @cards = cards
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def deal
    dealt_cards = []
    5.times do
      dealt_cards.push(self.top_card)
    end
    return dealt_cards
  end

  def cards_left
    @cards.length
  end

  def top_card
    @cards.shift
  end

  def set_deck(cards)
    @cards = cards
  end

  def clear_deck
    @cards = []
  end

  def as_json
    {
      'cards' => @cards.map { |card| card.as_json}
    }
  end

  def self.from_json(json)
    cards = json['cards'].map do |card|
      Card.new(rank:card['rank'], suit:card['suit'])
    end
    self.new(cards)
  end
end
