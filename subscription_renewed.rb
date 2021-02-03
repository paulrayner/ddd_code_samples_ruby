require 'date'

class SubscriptionRenewed
  attr_reader   :occurred_on
  attr_reader   :contract_id
  attr_reader   :reason

  def initialize(contract_id, reason)
    @occurred_on   = Date.today
    @contract_id   = contract_id
    @reason        = reason
  end
end
