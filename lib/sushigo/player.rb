module Sushigo
  class Player

    def initialize
      @deck = []
    end
    attr_accessor :deck

    # Since cards are already shuffled
    # we pick the top card
    def pick_one
      @deck.pop
    end
  end
end