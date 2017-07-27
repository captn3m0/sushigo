require 'sushigo/scoring'
require 'sushigo/player'
require 'sushigo/cards/deck'
# Game module
module Sushigo
  include Cards

  # These are the actual categories we are playing with

  MENU = [
    Chopstick,
    Dumpling,
    Maki,
    Nigiri,
    Pudding,
    Sashimi,
    Tempura,
    Wasabi
  ].freeze

  DESSERTS = [
    Pudding
  ].freeze

  # Primary Game class
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

      # This is as per the original Sushi Go Rules
      # And not the party rules
      @players.each do |player|
        player.deck = @deck.pop cards_per_player
      end
    end

    def full_hand_count
      12 - @count
    end

    def play
      3.times do |_i|
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
      Game.score_round(@meals)
    end

    def self.score_round(meals)
      scores = []

      Sushigo::MENU.each do |dish|
        scores << dish.score_round(meals)
      end

      scores.transpose.map { |player_scores| player_scores.reduce(:+) }
    end

    def self.score_dessert(desserts)
      scores = []
      # Already ready for Sushi Go Party
      # Where we have multiple desserts
      Sushigo::DESSERTS.each do |dessert|
        scores << dessert.score_dessert(desserts)
      end

      scores.transpose.map { |player_scores| player_scores.reduce(:+) }
    end
  end
end
