class RenewedSubscription
  attr_reader   :date
  attr_reader   :reason

  def initialize(date, reason)
    @date   = date
    @reason = reason
  end
end