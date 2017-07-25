require 'sushigo/cards/base'

module Sushigo::Cards
  class Tempura < Card
    def self.score_round(decks)
      scores = []
      decks.each do |deck|
        tempuras = deck.select { |c| c.is_a? Tempura }
        scores <<(tempuras.count/2).floor*5
      end
      scores
    end
  end

  class Sashimi < Card
    def self.score_round(decks)
      scores = []
      decks.each do |deck|
        sashimis = deck.select { |c| c.is_a? Sashimi}
        scores << (sashimis.count/3).floor * 10
      end
      scores
    end
  end

  class Dumpling < Card
    def self.score_round(decks)
      scores = []
      decks.each do |deck|
        lookup = [0, 1, 3, 6, 10, 15]
        dumplings = deck.select { |c| c.is_a? Dumpling}
        count = [dumplings.count, 5].min
        scores << lookup[count]
      end
      scores
    end
  end

  class Nigiri < Card
    def self.score_round(decks)
      scores = []
      decks.each do |deck|
        nigiris = deck.select { |c| c.is_a? self}
        scores << nigiris.inject(0){|sum,card| sum + card.class::SELF_SCORE }
      end
      scores
    end
  end

  class Egg < Nigiri
    SELF_SCORE ||= 1
  end

  class Salmon < Nigiri
    SELF_SCORE ||= 2
  end

  class Squid < Nigiri
    SELF_SCORE ||= 3
  end

  class Wasabi < Card
    def self.score_round(decks)
      scores = []

      decks.each do |deck|
        score = 0
        wasabi_indexes = deck.map.with_index{ |c, index| c.is_a?(Wasabi) ? index : nil}.compact
        nigiri_indexes = deck.map.with_index{ |c, index| c.is_a?(Nigiri) ? index : nil}.compact

        scored_nigiris = []

        wasabi_indexes.each do |i|
          # Keep going through all the nigiris after this index
          # and take them if one isn't taken
          nigiris_after_this_wasabi = nigiri_indexes.select do |k|
            # Find nigiris that are after this wasabi (k>i)
            # AND which are not included in the list of already
            # scored nigiris
            (k > i) and (! scored_nigiris.include? k)
          end

          # Take all the possible nigiris
          # and attempt to score them if
          # they have not been already claimed
          # by a Wasabi
          nigiris_after_this_wasabi.each do |j|
            unless scored_nigiris.include? j
              scored_nigiris << j
              score += 2 * deck[j].class::SELF_SCORE
              break
            end
          end
        end
        scores << score
      end
      scores
    end
  end

  # The player with the most pudding cards
  # scores 6 points. If multiple players tie for
  # the most, they split the points evenly
  # (ignoring any remainder).
  # The player with the fewest pudding cards
  # (including players with none) loses 6 points.
  # If multiple players tie for the least, they split the
  # lost points evenly (ignoring any remainder).
  #
  # Example: Chris has 4 pudding cards, Phil has 3 and Lisa and
  # Amy each have 0. Chris has the most and so scores 6 points.
  # Lisa and Amy tie for the least and so divide the lost 6 points
  # between them, each losing 3 points.
  #
  # On the rare occasion that all players have the same number of
  # pudding cards, no one scores anything for them.
  #
  # NOTE: In a 2 player game, no one loses any points for puddings.
  # Only the points for most pudding cards are awarded.
  class Pudding < Card
    # Round score is zero for pudding
    def self.score_dessert(decks)
      pudding_counts = decks.map { |deck| deck.select {|c| c.is_a? Pudding}.count}

      max = pudding_counts.max
      min = pudding_counts.min

      # No one scores anything if al players
      # scored the same
      if max == min
        return [0] * decks.size
      end

      max_puddings_player_count = pudding_counts.select {|count| count == max}.count
      min_puddings_player_count = pudding_counts.select {|count| count == min}.count

      scores = []

      pudding_counts.each do |count|
        # If you were the highest scoring player
        if count == max
          scores << (6.0/max_puddings_player_count).floor
        # if you were the least scoring player and
        # there were more than 2 players
        elsif count == min and decks.count > 2
          scores << (-6.0/min_puddings_player_count).ceil
        else
          scores << 0
        end
      end
      scores
    end
  end

  class Maki < Card
    def self.count_makis(deck)
      maki_cards = deck.select { |c| c.is_a? Maki}
      maki_cards.inject(0){|sum, card| sum + card.class::MAKIS }
    end

    def self.score_round(decks)
      scores = []
      all_counters = decks.map {|deck| count_makis(deck)}
      all_unique_maki_counts = all_counters.uniq.sort.reverse

      highest_counter = all_unique_maki_counts[0]
      second_highest_counter = all_unique_maki_counts[1]

      # These are the number of people who are sharing the highest
      # and the second highest counts
      number_highest = all_counters.select{|counter| counter == highest_counter}.size
      number_second_highest = all_counters.select{|counter| counter == second_highest_counter}.size

      all_counters.each do |count|
        if count > 0 and count === highest_counter
          scores << (6/number_highest).floor
        elsif count > 0 and count === second_highest_counter
          scores << (3/number_second_highest).floor
        else
          scores << 0
        end
      end
      scores
    end
  end

  # These are all different cards
  # So we use different classes
  # for each of them
  class Maki1 < Maki
    MAKIS = 1
  end

  class Maki2 < Maki
    MAKIS = 2
  end

  class Maki3 < Maki
    MAKIS = 3
  end

  # They score zero always
  class Chopstick < Card
  end
end