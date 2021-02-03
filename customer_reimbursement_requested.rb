require 'date'

class CustomerReimbursementRequested
  attr_reader   :occurred_on
  attr_reader   :contract_id
  attr_reader   :rep_name
  attr_reader   :reason

  def initialize(contract_id, rep_name, reason)
    @occurred_on = Date.today
    @contract_id = contract_id
    @rep_name    = rep_name
    @reason      = reason
  end
end
