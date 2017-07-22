require 'sushigo/cards/types'

module Sushigo::Cards
  class Deck
    include Cards
    # The standard sushi-go deck
    @deck =
      [TEMPURA]     * 14 +
      [SASHIMI]     * 14 +
      [DUMPLING]    * 14 +
      [MAKI2]       * 12 +
      [MAKI3]       * 8  +
      [MAKI1]       * 6  +
      [SALMON]      * 10 +
      [SQUID]       * 5  +
      [EGG]         * 5  +
      [PUDDING]     * 10 +
      [WASABI]      * 6  +
      [CHOPSTICKS]  * 4
  end
end