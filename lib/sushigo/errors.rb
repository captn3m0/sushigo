# Parent game module
module Sushigo
  # All errors come here
  module Errors
    # All recoverable errors come here
    class Warning < ::RuntimeError
    end

    # You called SushiGo wrongly
    class WrongSushiGo < Warning
    end

    # You don't have a chopstick to call Sushi Go
    class WrongSushiGoNoChopstick < WrongSushiGo
      def to_s
        "You don't have a chopstick to call Sushi Go"
      end
    end
    # You can't call Sushi Go on the last hand
    class WrongSushiGoLastHand < WrongSushiGo
      "You can't call Sushi Go on the last hand"
    end
  end
end
