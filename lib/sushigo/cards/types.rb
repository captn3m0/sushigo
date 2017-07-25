require 'sushigo/cards/base'

# TODO: Change the scoring so that it
# takes an array of meals and returns
# an array of scores for all Types
# Makes it much easier to manage across
# different types of cards.
module Sushigo::Cards
  class Tempura < Card
    def self.score_round(deck, other_decks = [])
      tempuras = deck.select { |c| c.is_a? Tempura }
      (tempuras.count/2).floor*5
    end
  end

  class Sashimi < Card
    def self.score_round(deck, other_decks = [])
      sashimis = deck.select { |c| c.is_a? Sashimi}
      (sashimis.count/3).floor * 10
    end
  end

  class Dumpling < Card
    def self.score_round(deck, other_decks = [])
      lookup = [0, 1, 3, 6, 10, 15]
      dumplings = deck.select { |c| c.is_a? Dumpling}
      count = [dumplings.count, 5].min
      lookup[count]
    end
  end

  class Nigiri < Card
    def self.score_round(deck, other_decks = [])
      nigiris = deck.select { |c| c.is_a? self}
      nigiris.inject(0){|sum,card| sum + card.class::SELF_SCORE }
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
    def self.score_round(deck, other_decks = [])
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

      score
    end
  end

  class Pudding < Card
    # Round score is zero for pudding
    def self.game_score(deck, other_decks)
      own_puddings = deck.select {|c| c.is_a? Pudding}.count
      other_pudding_counts = other_decks.map do |d|
        deck.select {|c| c.is_a? Pudding}.count
      end

      max = other_pudding_counts.max
      min = other_pudding_counts.min

      max_puddings_player_count = other_pudding_counts.select {|count| count == max}
      min_puddings_player_count = other_pudding_counts.select {|count| count == min}

      score = 0

      if own_puddings >= max
        score = 6 / (max_puddings_player_count + 1)
      end

      if own_puddings <= min
        score = -6 / (min_puddings_player_count + 1)
      end

    end
  end

  class Maki < Card
    def self.count_makis(deck)
      maki_cards = deck.select { |c| c.is_a? Maki}
      maki_cards.inject(0){|sum, card| sum + card.class::MAKIS }
    end

    def self.score_round(deck, other_decks = [])
      self_count = count_makis deck

      all_counters = ([deck] + other_decks).map {|deck| count_makis(deck)}

      all_unique_maki_counts = all_counters.uniq.sort.reverse

      highest_counter = all_unique_maki_counts[0]
      # puts "HIGHEST: #{highest_counter}"
      second_highest_counter = all_unique_maki_counts[1]
      # puts "SECOND_HIGHEST: #{second_highest_counter}"

      # These are the number of people who are sharing the highest
      # and the second highest counts
      number_highest = all_counters.select{|counter| counter == highest_counter}.size
      number_second_highest = all_counters.select{|counter| counter == second_highest_counter}.size

      puts "#{number_highest} | #{number_second_highest}"

      # equal because we included self in the counters array
      if self_count > 0  and self_count == highest_counter
        return (6 / number_highest).floor
      end

      if self_count > 0 and self_count == second_highest_counter and number_highest == 1
        return (3 / number_second_highest).floor
      end

      0
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