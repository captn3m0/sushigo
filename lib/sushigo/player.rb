# Game module
module Sushigo
  # Player class
  class Player
    attr_writer :meal, :deck
    attr_reader :playing_chopstick

    def initialize
      @playing_chopstick = false
      @deck = []
    end

    attr_accessor :deck

    # Since cards are already shuffled
    # we pick the top card
    def pick_one

      raise "Empty Deck" if @deck.empty?

      picked_card = @deck.pop

      if @meal.include?(Sushigo::Deck::CHOPSTICK) && @deck.size > 1
        # 20% chance of calling out a sushigo
        sushigo if rand(1..5) == 3
      end

      picked_card
    end

    # You played Chopsticks
    # so you get to select one extra card from
    # the same deck. The game takes care to
    # take away your chopstick
    def chopstick
      @playing_chopstick = false
      @deck.pop
    end

    private

    # You shout sushigo if you want to
    # play a chopstick
    def sushigo
      @playing_chopstick = true
    end
  end
end
