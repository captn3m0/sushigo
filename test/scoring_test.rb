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
  end
end