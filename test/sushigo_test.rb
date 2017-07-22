require 'test_helper'

class SushigoTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Sushigo::VERSION
  end

  def test_that_we_can_setup_the_game
    game = Sushigo::Game.new(players: 2)
    game.setup

    # Standard deck is 108 cards
    # so 88 cards are left undealt
    assert_equal 88, game.deck.size
    # For a 2 player game, 10 cards each
    assert_equal 10, game.players[0].deck.size
    assert_equal 10, game.players[1].deck.size
  end

  def test_that_the_game_runs
    game = Sushigo::Game.new(players: 4)
    game.play
  end
end
