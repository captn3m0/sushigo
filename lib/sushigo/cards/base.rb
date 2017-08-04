module Sushigo
  # Sushigo game module
  module Cards
    # Base Card class
    class Card
      def score_dessert(desserts)
        [0] * desserts.size
      end

      def self.score_round(decks)
        [0] * decks.size
      end

      # Remove module name from the Card names
      def to_s
        self.class.to_s.gsub(/^.*::/, '')
      end
    end
  end
end
