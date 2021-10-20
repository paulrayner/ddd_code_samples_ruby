require 'securerandom'


# Claim represents a request for a benefit on an extended warranty. It contains
# a set of purchase orders that provide information about any repairs and
# associated costs that may have occurred for a claim.

class Claim
  attr_reader   :id # unique id
  attr_reader   :amount, :date
  attr_accessor :repair_pos

  def initialize(amount, date)
    @id         = SecureRandom.uuid
    @amount     = amount
    @date       = date
    @repair_pos = Array.new
  end

  # Equality for entities is based on unique id
  def ==(other)
    self.id == other.id
  end
end
