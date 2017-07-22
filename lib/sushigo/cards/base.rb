module Sushigo::Cards
  class Card
    def game_score(d)
      0
    end

    def self.score_round(deck, other_decks = [])
      0
    end

    def to_s
      self.class.name
    end
  end
end