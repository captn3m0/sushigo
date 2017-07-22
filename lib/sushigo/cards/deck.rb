require 'sushigo/cards/types'

module Sushigo::Cards
  class Deck

    TEMPURA     = Tempura.new
    SASHIMI     = Sashimi.new
    DUMPLING    = Dumpling.new

    MAKI1       = Maki1.new
    MAKI2       = Maki2.new
    MAKI3       = Maki3.new

    WASABI      = Wasabi.new
    EGG         = Egg.new
    SALMON      = Salmon.new
    SQUID       = Squid.new

    PUDDING     = Pudding.new
    CHOPSTICK   = Chopstick.new

    # The standard sushi-go deck
    def self.standard
      Array.new(14, TEMPURA) +
      Array.new(14, SASHIMI) +
      Array.new(14, DUMPLING) +
      Array.new(12, MAKI2) +
      Array.new(8, MAKI3) +
      Array.new(6, MAKI1) +
      Array.new(10, SALMON) +
      Array.new(5, SQUID) +
      Array.new(5, EGG) +
      Array.new(10, PUDDING) +
      Array.new(6, WASABI) +
      Array.new(4, CHOPSTICK)
    end

  end
end