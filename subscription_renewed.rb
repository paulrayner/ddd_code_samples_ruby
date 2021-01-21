require 'date'

class SubscriptionRenewed
  attr_reader   :occurred_on
  attr_reader   :reason

  def initialize(reason)
    @occurred_on   = Date.today
    @reason        = reason
  end
end
