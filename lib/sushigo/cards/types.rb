require 'sushigo/cards/base'

module Sushigo::Cards
  class Tempura < Card
    def round_score(deck)
      tempuras = d.select { |c| c.is_a? Tempura }
      (tempuras.count/2).floor * 5
    end
  end

  class Sashimi < Card
    def round_score(deck)
      sashimis = d.select { |c| c.is_a? Sashimi}
      (sashimis.count/3).floor * 10
    end
  end

  class Dumpling < Card
    def round_score(deck)
      dumplings = d.select { |c| c.is_a? Dumpling}
      sets = (dumplings/5).floor
      remainders = dumplings % 5
      lookup = [0, 1, 3, 6, 10, 15]
      sets * 15 + lookup[remainders]
    end
  end

  class Nigiri
    def round_score(deck)
      score = 0
      # Only works for cards that didn't have a nigiri behind them
      nigiris = d.each do |card, index|
        if card.is_a? Nigiri
          score += card.class.SELF_SCORE
        end
      end
      score
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
    def round_score(deck)
      score = 0
      d.each do |card, index|
        if card.is_a? Wasabi
          if d[index+1].is_a? Nigiri
            # add the double score because of wasabi
            score += d[index+1].class.SELF_SCORE * 2
          end
        end
      end
    end
  end

  class Pudding < Card
    def game_score(deck, *other_decks)
      own_puddings = deck.select {|c| c.is_a? Pudding}.count
      other_pudding_counts = other_decks.map do |d|
        d.select {|c| c.is_a? Pudding}.count
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
    def count_makis(deck)
      maki_count = 0

      # TODO: Replace with reduce
      deck.each do |card|
        maki_count += card.class.MAKIS if card.is_a? Maki
      end

      maki_count
    end

    def round_score(deck, *other_decks)
      self_count = count_makis deck

      all_counters = ([deck] + other_decks).map count_makis

      all_unique_maki_counts = all_counters.uniq.sort.reverse

      highest_counter = all_unique_maki_counts[0]
      second_highest_counter = all_unique_maki_counts[1]

      number_highest = all_counters.select {|counter| counter == highest_counter}.size
      number_second_highest = all_counters.select {|counter| counter == second_highest_counter}.size

      # equal because we included self in the counters array
      if self_count > 0  and self_count == highest_counter
        return (6 / number_highest).floor
      end

      if self_count > 0 and self_count == second_highest_counter and number_highest == 1
        return (3 / number_second_highest).floor
      end
    end
  end

  # These are all different cards
  # So we use different classes
  # for each of them
  class Maki1 < Maki
    MAKIS ||= 1
  end

  class Maki2 < Maki
    MAKIS ||= 2
  end

  class Maki3 < Maki
    MAKIS ||= 3
  end

  # They score zero always
  class Chopstick < Card
  end
end