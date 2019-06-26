class Player
  attr_reader :cards, :name, :matches, :points
  def initialize(name:, cards: [], matches: [], points: 0)
    @name = name
    @matches = matches
    @points = points.to_i
    if cards.length == 0
      @cards = []
    else
      @cards = cards
    end
  end

  def cards_left
    @cards.length
  end

  def card_in_hand(rank)
    result = []
    @cards.each do |card|
      if card.rank == rank
        result.push(card)
      end
    end
    if result.length == 0
      return 'Go Fish!'
    end
    @cards = @cards.select {|card| card.rank != rank}
    return result
  end

  def set_hand(cards)
    @cards = cards
  end

  def pair_cards
    @cards.each do |original_card|
      matches = @cards.select { |card| card.rank == original_card.rank}
      if matches.length == 4
        @matches.push(matches[0])
        @cards = @cards.select { |card| !matches.include?(card)}
        @points += 1
      end
    end
  end

  def take_cards(cards)
    if cards.kind_of?(Array)
      cards.each do |card|
        @cards.push(card)
      end
    else
      @cards.push(cards)
    end
  end

  def as_json
    {
      "name" => @name,
      "cards" => @cards.map(&:as_json),
      "matches" => @matches.map(&:as_json),
      "points" => "#{@points}"
    }
  end

  def self.from_json(json)
    cards = json['cards'].map { |card| Card.new(rank: card['rank'], suit: card['suit'])}
    self.new(name: json['name'], cards: cards, matches: json['matches'], points: json['points'])
  end
end
