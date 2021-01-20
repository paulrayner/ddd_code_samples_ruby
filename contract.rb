# frozen_string_Literal: true

require_relative './product'

class Contract
  attr_reader   :id # unique id (assigned automatically)
  attr_reader   :purchase_price
  attr_reader   :covered_product

  attr_accessor :status
  attr_accessor :effective_date
  attr_accessor :expiration_date
  attr_accessor :purchase_date
  attr_accessor :in_store_guarantee_days

  attr_accessor :claims

  ACTIVE_STATUS = 'ACTIVE'

  def initialize(purchase_price, covered_product)
    @purchase_price     = purchase_price
    @status             = "PENDING"
    @covered_product    = covered_product
    @claims             = Array.new
  end

  def covers?(new_claim)
     within_liability?(new_claim) && in_effect_for?(new_claim)
  end

  private

  def claim_total
    claims.sum(&:amount)
  end

  def limit_of_liability
    (purchase_price - claim_total) * 0.8
  end

  def within_liability?(claim)
    limit_of_liability > claim.amount
  end

  # TODO: Ask domain expoert about naming
  def in_effect_for?(claim)
    active? &&
      claim.date  >= effective_date &&
      claim.date  <= expiration_date
  end

  def active?
    status == ACTIVE_STATUS
  end
end
