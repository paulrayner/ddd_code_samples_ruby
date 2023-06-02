require_relative './product'
require_relative './terms_and_conditions'
require_relative './subscription_renewed'

# Contract represents an extended warranty for a covered product.
# A contract is in a PENDING state prior to the effective date,
# ACTIVE between effective and expiration dates, and EXPIRED after
# the expiration date.

class Contract
  attr_reader   :id # unique id

  attr_reader   :purchase_price
  attr_reader   :covered_product
  attr_reader   :terms_and_conditions
  attr_reader   :events

  attr_accessor :status
  attr_accessor :claims

  LIABILITY_PERCENTAGE = 0.8

  def initialize(purchase_price, covered_product, terms_and_conditions)
    @id                   = SecureRandom.uuid
    @status               = "PENDING"
    @purchase_price       = purchase_price
    @covered_product      = covered_product
    @terms_and_conditions = terms_and_conditions
    @claims               = Array.new
    @events               = Array.new
  end

  def covers?(claim)
    in_effect_for?(claim.failure_date) &&
    within_limit_of_liability?(claim.amount)
  end

  def within_limit_of_liability?(amount)
    amount < limit_of_liability()
  end

  def in_effect_for?(current_date)
    @terms_and_conditions.active?(current_date) &&
    @status == "ACTIVE"
  end

  def limit_of_liability()
    (@purchase_price * LIABILITY_PERCENTAGE) - claim_total()
  end

  def claim_total()
    claim_total = 0.0
    @claims.each { |claim|
      claim_total += claim.amount
    }
    claim_total
  end

  def extend_annual_subscription
    @terms_and_conditions = @terms_and_conditions.annually_extended
    @events << SubscriptionRenewed.new(id, "Automatic Annual Renewal")
  end

  def ==(other)
    self.id == other.id
  end
end
