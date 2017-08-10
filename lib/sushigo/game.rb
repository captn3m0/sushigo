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
      raise 'Invalid number of players' unless @players.size == @count
      @desserts = []
      @deck = Cards::Deck.standard
    end

    # We setup the game
    def setup_game
      @deck.shuffle!
    end

    def full_hand_count
      12 - @count
    end

    def play
      round_scores = []
      3.times do |_i|
        setup_game
        round_scores << play_round
      end
      dessert_scores = Game.score_dessert(@desserts)
      Game.calc_final_scores(round_scores, dessert_scores)
    end

    def self.calc_final_scores(round, dessert)
      scores = round << dessert
      scores.transpose.map { |player_scores| player_scores.reduce(:+) }
    end

    def setup_round
      # In a 2 player game, deal 10 cards to each player.
      # In a 3 player game, deal 9 cards to each player.
      # In a 4 player game, deal 8 cards to each player.
      # In a 5 player game, deal 7 cards to each player
      cards_per_player = full_hand_count

      # This is as per the original Sushi Go Rules
      # And not the party rules
      @players.each do |player|
        player.deck = @deck.pop cards_per_player
        raise 'Player deck size mismatch' unless player.deck.size == cards_per_player
      end

      @meals = []

      @count.times do |index|
        @meals[index] = []
      end
    end

    def play_chopstick(player, meal)
      if meal.include? Cards::Deck::CHOPSTICK
        # We ask the player
        if player.deck.size >= 1 and second_card = player.sushigo

          raise 'Pick a card' unless second_card.is_a? Cards::Card

          meal << second_card

          # Find the first chopstick and remove it
          meal.delete_at meal.index(Cards::Deck::CHOPSTICK)

          # Then add a new chopstick to the player's deck
          # before it is passed
          player.deck << Cards::Deck::CHOPSTICK
        end
      end
    end

    def play_round
      setup_round

      full_hand_count.times do
        deck_passed_to_me = nil
        @players.each_with_index do |player, index|
          # Show the player their meal so far
          meal = player.meal = @meals[index]
          # Agent is called
          #
          card = player.pick_one

          raise 'Card not returned' unless card.is_a?(Cards::Card)

          meal << card

          play_chopstick player, meal

          hold = player.deck

          player.deck = deck_passed_to_me unless deck_passed_to_me.nil?

          # Now we pass the deck
          deck_passed_to_me = hold
        end

        @players[0].deck = deck_passed_to_me
      end

      save_desserts_for_later

      Game.score_round(@meals)
    end

    def save_desserts_for_later
      @meals.each_with_index do |meal, index|
        @desserts[index] ||= []
        @desserts[index] += meal.select { |c| c.is_a? Sushigo::Cards::Dessert }
      end
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

    def display
      @meals.each do |meal|
        puts meal.join ', '
      end
    end
  end
end
