class GoFish
  attr_reader :players, :deck, :log, :bots
  def initialize(names: [], turn: 0, player_count:, players: [], deck: Deck.new(), log: [], bots:  [])
    if players.length == 0
      @players = []
      @bots = []
      @log = []
      @names = names
      names.each do |name|
        @players.push(Player.new(name: name))
      end
      index = 0
      while @players.length < player_count
        bot = Player.new(name: "Bot #{index += 1}")
        @players.push(bot)
        @bots.push(bot)
      end
      @turn = 0
      @deck = deck
    else
      @players = players
      @deck = deck
      @turn = turn
      @log = log
    end
  end

  def start_game
    @deck.shuffle
    players().each do |player|
      player.take_cards(@deck.deal)
    end
  end

  def updateGameLog(result:, rank:, player:, target:)
    string = ''
    if result == "Go Fish!"
      string = "#{player.name()} asked for #{rank.upcase}s from #{target.name()}, but went fishing"
    else
      string = "#{player.name()} took all the #{rank.upcase}s from #{target.name()}"
    end
    @log.unshift(string)
    if @log.length > 10
      @log.pop()
    end
  end

  def play_round(current_player, target_player, rank)
    player = find_player_by_name(current_player)
    target = find_player_by_name(target_player)
    result = target.card_in_hand(rank)
    if result == 'Go Fish!'
      if @deck.cards_left > 0
        player.take_cards(@deck.top_card)
        player.pair_cards
      end
      next_turn()
    else
      player.take_cards(result)
      player.pair_cards
    end
    updateGameLog(result: result, rank: rank, player: player, target: target)
    card_refills
    skip_finished_players
  end

  def stats
    player_stats = []
    players().each do |player|
      player_stats.push([player.name, player.points])
    end
    player_stats.sort_by! { |player| player[1] }.reverse
  end

  def card_refills
    players().each do |player|
      if player.cards_left == 0
        5.times do
          if @deck.cards_left > 0
            player.take_cards(@deck.top_card)
          end
        end
      end
    end
  end

  def skip_finished_players
    while players()[@turn].cards_left == 0 && any_players_have_cards() == true
      next_turn()
    end
  end

  def any_players_have_cards
    result = false
    players().each do |player|
      if player.cards_left != 0
        result = true
      end
    end
    return result
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
    bots = json['bots'].map { |bot| Player.from_json(bot) }
    self.new(bots: bots, turn: json['turn'].to_i, log: json['log'], players: players, player_count: json['players'].length, deck: Deck.from_json(json['deck']))
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
      'requesting_player' => "#{@players[@turn].name}",
      'opponents' => opponents_to(player_name),
      'deck_amount' => deck().cards_left,
      'game_active' => "#{any_players_have_cards()}",
      'log' => log_as_json(),
      'bots' => bots().map(&:as_json)
    }
  end

  def log_as_json
    return @log
  end

  def as_json(*)
    {
      "players" => players().map { |player| player.as_json },
      "deck" => deck().as_json,
      "turn" => "#{@turn}",
      "log" => log_as_json(),
      "bots" => bots().map { |bot| bot.as_json }
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
