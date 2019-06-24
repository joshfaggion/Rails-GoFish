class GoFish
  attr_reader :players, :deck
  def initialize(names: [], turn: 0, player_count:, players: [], deck: Deck.new())
    if players.length == 0
      @players = []
      @names = names
      names.each do |name|
        @players.push(Player.new(name: name))
      end
      @turn = 0
      @deck = deck
    else
      @players = players
      @deck = deck
      @turn = turn
    end
  end

  def start_game
    @deck.shuffle
    players().each do |player|
      player.take_cards(@deck.deal)
    end
  end

  def find_player_by_name(name)
    @players.detect{ |player| player.name == name }
  end

  def self.from_json(json)
    players = json['players'].map { |player| Player.from_json(player) }
    self.new(turn: json['turn'].to_i, players: players, player_count: json['players'].length, deck: Deck.from_json(json['deck']))
  end

  def self.load(json)
    return nil if json.blank?
    self.from_json(json)
  end

  def self.dump(object)
    object.as_json
  end

  def is_turn?(player)
    if players().index(player) == @turn
      true
    else
      false
    end
  end

  def state_for(player_name)
    player = find_player_by_name(player_name)
    {
      'player' => player.as_json,
      'is_turn' => "#{is_turn?(player)}",
      'opponents' => opponents_to(player)
    }
  end

  #   player = find_player_by_name(player_name)
  #   { "player" => {
  #       "cards" => player.cards.map(&:as_json),
  #       "is_turn" => "#{is_turn?(player)}",
  #       "matches" => player.matches.map(&:as_json)
  #     },
  #     "opponents" => opponents_to(player_name)
  #   }

  # Use reader methods instead of instance variables

  def as_json(*)
    {
      "players" => players().map { |player| player.as_json },
      "deck" => deck().as_json,
      "turn" => "#{@turn}"
    }
  end

  private

  def opponents_to(current_player)
    players = players().map do |player|
      unless player.name == current_player
        return "#{player.name}" => {
            "card_amount" => player.cards_left,
            "matches" => player.matches.map(&:as_json)
          }
      end
    end
    return players
  end
end
