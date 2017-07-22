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
    attr_reader :deck, :players, :meals

    def initialize(options)
      @players = []
      @count = options[:players]
      @count.times do
        @players << Player.new
      end
      @deck = Cards::Deck.standard
    end

    # We setup the game
    def setup
      # In a 2 player game, deal 10 cards to each player.
      # In a 3 player game, deal 9 cards to each player.
      # In a 4 player game, deal 8 cards to each player.
      # In a 5 player game, deal 7 cards to each player
      cards_per_player = full_hand_count

      @deck.shuffle!
      @players.each do |player|
        player.deck = @deck.pop cards_per_player
      end

    end

    def full_hand_count
      12 - @count
    end

    def play
      3.times do |i|
        setup
        play_round
      end
    end

    def play_round
      @meals = []
      @count.times do |index|
        @meals[index] = []
      end
      full_hand_count.times do
        @players.each_with_index do |player, index|
          card = player.pick_one
          @meals[index] << card
        end
      end
    end

  end
end