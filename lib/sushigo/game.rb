require 'sushigo/scoring'
require 'sushigo/player'
require 'sushigo/cards/deck'
require 'sushigo/errors'

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
        temporary_deck = nil
        @players.each_with_index do |player, index|
          # Show the player their meal so far
          meal = @players[index].meal = @meals[index]
          # Agent is called
          card = player.pick_one
          @meals[index] << card

          # Now, before we pass we check for sushigo
          if player.playing_chopstick
            unless @meals[index].include? Cards::Deck::CHOPSTICK
              raise Sushigo::Errors::WrongSushiGoNoChopstick
            end

            unless player.deck.size >= 1
              raise Sushigo::Errors::WrongSushiGoLastHand
            end

            # Find what the player wants to collect extra
            second_card = player.chopstick

            second_card.is_a?(Cards::Card) || raise('Pick a card')

            meal << second_card

            # Find the first chopstick and remove it
            meal.delete_at meal.index(Cards::Deck::CHOPSTICK)

            # Then add a new chopstick to the player's deck
            # before it is passed
            player.deck << Cards::Deck::CHOPSTICK
          end

          if temporary_deck
            player_to_pass = index + 1
            player_to_pass = 0 if index == @players.size - 1
            @players[player_to_pass].deck = temporary_deck
          end

          temporary_deck = player.deck
        end
      end

      Game.score_round(@meals)
    end

    def pick_and_pass; end

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
