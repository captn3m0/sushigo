require 'test_helper'

class SushigoTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Sushigo::VERSION
  end

  def test_that_we_can_instantiate_the_game
    game = Sushigo::Game.new
  end
end
