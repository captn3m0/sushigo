# Game module
module Sushigo
  # Scoring base class
  class Scoring
    # Score the single round and return a number
    def score_round(deck, other_decks); end

    # This is the player deck at the end of the game
    def score_game(deck, other_decks); end
  end
end
