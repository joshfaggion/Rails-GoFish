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

  def play_round(current_player, target_player, rank)
    player = find_player_by_name(current_player)
    target = find_player_by_name(target_player)
    result = target.card_in_hand(rank)
    if result == 'Go Fish!'
      player.take_cards(@deck.top_card)
      next_turn()
    else
      player.take_cards(result)
    end
  end

  def next_turn
    @turn += 1
    if @turn == @players.length
      @turn = 0
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
      'opponents' => opponents_to(player_name),
      'deck_amount' => deck().cards_left
    }
  end

  def as_json(*)
    {
      "players" => players().map { |player| player.as_json },
      "deck" => deck().as_json,
      "turn" => "#{@turn}"
    }
  end

  private

  def opponents_to(player_name)
    arr = []
    players().each do |player|
      unless player.name == player_name
        arr.push({
            "name" => player.name,
            "card_amount" => player.cards_left,
            "matches" => player.matches.map(&:as_json)
          })
      end
    end
    return arr
  end
end
