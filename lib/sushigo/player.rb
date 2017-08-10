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
