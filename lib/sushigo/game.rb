require 'sushigo/cards/cards'
require 'sushigo/scoring'
require 'sushigo/player'

module Sushigo
  include Cards
  # These are the actual categories we are playing with
  MENU = [
    Chopstick,
    Dumpling,
    Maki,
    Nigiri,
    Pudding,
    Tempura,
    Wasabi,
    Chopstick
  ]

  KEEPER_CARDS = [
    Pudding
  ]

  class Game
    def initialize(players = [])
      @players = players
      # Define stages here
    end
  end
end