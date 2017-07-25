module Sushigo::Cards
  class Card
    def score_dessert(desserts)
      [0] * desserts.size
    end

    def self.score_round(decks)
      [0] * decks.size
    end

    def to_s
      self.class.name
    end
  end
end