module Sushigo
  class Player

    def initialize
      @deck = []
    end
    attr_accessor :deck

    def pick_one
      @deck.shuffle!.pop
    end
  end
end