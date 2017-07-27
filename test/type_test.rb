require 'test_helper'

class TypeTest < Minitest::Test
  def test_that_including_deck_works
    assert Sushigo::Cards
    assert Sushigo::Cards::Deck
    assert Sushigo::Cards::Card
    assert Sushigo::Cards::Tempura
    assert Sushigo::Cards::Sashimi
    assert Sushigo::Cards::Dumpling
    assert Sushigo::Cards::Nigiri
    assert Sushigo::Cards::Egg
    assert Sushigo::Cards::Salmon
    assert Sushigo::Cards::Squid
    assert Sushigo::Cards::Wasabi
    assert Sushigo::Cards::Pudding
    assert Sushigo::Cards::Maki
    assert Sushigo::Cards::Maki1
    assert Sushigo::Cards::Maki2
    assert Sushigo::Cards::Maki3
  end

  def test_other_classes
    assert Sushigo::Player
    assert Sushigo::Game
  end
end
