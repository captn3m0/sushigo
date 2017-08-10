# Game module
module Sushigo
  # Player class
  class Player
    attr_accessor :deck
    attr_writer :meal

    def initialize
      @deck = []
    end

    # Since cards are already shuffled
    # we pick the top card
    def pick_one
      raise 'Empty Deck' if @deck.empty?
      @deck.pop
    end

    # You shout sushigo if you want to
    # play a chopstick
    def sushigo
      @deck.pop if rand(1..5) == 3
    end
  end
end
