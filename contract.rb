require_relative './product'
require_relative './terms_and_conditions'
require_relative './customer_reimbursement'
require_relative './renewed_subscription'

class Contract
  attr_accessor :id # unique id (assigned automatically)
  attr_reader   :purchase_price
  attr_reader   :covered_product
  attr_reader   :terms_and_conditions
  attr_reader   :events

  attr_accessor :status
  attr_accessor :claims

  LIABILITY_PERCENTAGE = 0.8

  def initialize(purchase_price, covered_product, terms_and_conditions)
    @purchase_price       = purchase_price
    @covered_product      = covered_product
    @terms_and_conditions = terms_and_conditions
    @claims               = Array.new
    @events               = Array.new
  end

  def status(current_date)
    if @events.any? {|event| event.is_a? CustomerReimbursement}
      "FULFILLED"
    else
      @terms_and_conditions.status(current_date)
    end
  end

  def limit_of_liability()
    claim_total = 0.0
    @claims.each { |claim|
      claim_total += claim.amount
    }
    (@purchase_price * LIABILITY_PERCENTAGE) - claim_total
  end

  def extend_annual_subscription
    @terms_and_conditions = @terms_and_conditions.annually_extended
    @events << RenewedSubscription.new(Date.today, "Manual Renewal")
  end

  def terminate
    @events << CustomerReimbursement.new(Date.today, "Limit of Liability Exceeded")
  end

  def ==(other)
    self.id == other.id
  end
end
