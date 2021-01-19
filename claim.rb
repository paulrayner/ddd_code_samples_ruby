class Claim
  attr_reader   :id # unique id (assigned automatically)
  attr_reader   :amount, :date
  attr_accessor :repair_pos

  def initialize(amount, date)
    @amount     = amount
    @date       = date
    @repair_pos = Array.new
  end
end
