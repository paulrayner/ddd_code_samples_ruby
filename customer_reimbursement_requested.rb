require 'date'

class CustomerReimbursementRequested
  attr_reader   :occurred_on
  attr_reader   :reason
  attr_reader   :rep_name

  def initialize(reason, rep_name)
    @occurred_on = Date.today
    @reason      = reason
    @rep_name    = rep_name
  end
end
