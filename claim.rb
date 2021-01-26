require 'securerandom'

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
