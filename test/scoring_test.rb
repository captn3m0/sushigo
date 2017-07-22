require 'test_helper'

module Sushigo::Cards
  class ScoringTest < Minitest::Test
    def assert_score score, deck
      scores = Sushigo::Game.score_round [deck]
      assert_equal score, scores[0]
    end

    def test_that_tempuras_can_be_scored
      assert_score 10, [Deck::TEMPURA] * 4
      assert_score 5, [Deck::TEMPURA] * 2
      assert_score 15, [Deck::TEMPURA] * 6
      assert_score 15, [Deck::TEMPURA] * 7
      assert_score 0, [Deck::TEMPURA] * 1
      assert_score 5, [Deck::TEMPURA] * 2
    end

    def test_that_dumplings_can_be_scored
      assert_score 1, [Deck::DUMPLING]
      assert_score 3, [Deck::DUMPLING] * 2
      assert_score 6, [Deck::DUMPLING] * 3
      assert_score 10, [Deck::DUMPLING] * 4
      assert_score 15, [Deck::DUMPLING] * 5
      assert_score 15, [Deck::DUMPLING] * 6
    end

    def test_that_sashimi_can_be_scored
      assert_score 0, [Deck::SASHIMI]
      assert_score 0, [Deck::SASHIMI] * 2
      assert_score 10, [Deck::SASHIMI] * 3
      assert_score 10, [Deck::SASHIMI] * 4
      assert_score 10, [Deck::SASHIMI] * 5
      assert_score 20, [Deck::SASHIMI] * 6
      assert_score 20, [Deck::SASHIMI] * 7
      assert_score 20, [Deck::SASHIMI] * 8
      assert_score 30, [Deck::SASHIMI] * 9
    end

    def test_that_nigiris_alone_are_scored
      assert_score 1, [Deck::EGG]
      assert_score 2, [Deck::EGG] * 2
      assert_score 3, [Deck::EGG] * 3

      assert_score 2, [Deck::SALMON]
      assert_score 4, [Deck::SALMON] * 2
      assert_score 6, [Deck::SALMON] * 3

      assert_score 3, [Deck::SQUID]
      assert_score 6, [Deck::SQUID] * 2
      assert_score 9, [Deck::SQUID] * 3

      assert_score 6, [Deck::EGG, Deck::SALMON, Deck::SQUID]
      assert_score 10, [Deck::EGG, Deck::EGG, Deck::SQUID, Deck::SALMON, Deck::SQUID]
    end
  end
end