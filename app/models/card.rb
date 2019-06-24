class Card
  attr_reader :rank, :suit
  def initialize(rank:, suit:)
    @rank = rank
    @suit = suit
  end

  def value
    "#{@suit}#{@rank}"
  end

  def as_json
    {
      'rank' => @rank,
      'suit' => @suit
    }
  end

  def self.from_json(json)
    self.new(rank: json['rank'], suit: json['suit'])
  end
end
