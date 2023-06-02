require 'securerandom'


# Claim represents a request for a benefit on an extended warranty. It contains
# a set of purchase orders that provide information about any repairs and
# associated costs that may have occurred for a claim.

class Claim
  attr_reader   :id # unique id
  attr_reader   :amount, :failure_date
  attr_accessor :repair_pos
  attr_accessor :status

  def initialize(amount, failure_date)
    @id           = SecureRandom.uuid
    @amount       = amount
    @failure_date = failure_date
    @repair_pos   = Array.new
  end

  def ==(other)
    self.id == other.id
  end
end
