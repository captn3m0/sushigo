require 'sushigo/scoring'
require 'sushigo/player'
require 'sushigo/cards/deck'

module Sushigo
  include Cards
  # These are the actual categories we are playing with
  MENU = [
    Chopstick,
    Dumpling,
    Maki,
    Nigiri,
    Pudding,
    Tempura,
    Wasabi,
    Chopstick
  ]

  KEEPER_CARDS = [
    Pudding
  ]

  class Game
    attr_reader :deck, :players
    def initialize(options)
      @count = options[:players]
      @players = Array.new(@count, Player.new)
      # We play the game over 3 meals
    end

    # We setup the game
    def setup
      # In a 2 player game, deal 10 cards to each player.
      # In a 3 player game, deal 9 cards to each player.
      # In a 4 player game, deal 8 cards to each player.
      # In a 5 player game, deal 7 cards to each player
      cards_per_player = 12 - @count

      @deck = Cards::Deck.standard

      @deck.shuffle
      @players.each do |player|
        player.deck = @deck.pop cards_per_player
      end
    end
  end
end