require 'securerandom'

class Claim
  attr_reader   :id # unique id

  attr_reader   :amount
  attr_reader   :date

  attr_accessor :repair_pos
  attr_accessor :status

  def initialize(amount, date)
    @id         = SecureRandom.uuid
    @amount     = amount
    @date       = date
    @repair_pos = Array.new
  end
end
