require 'securerandom'

require_relative './product'

# Contract represents an extended warranty for a covered product.
# A contract is in a PENDING state prior to the effective date,
# ACTIVE between effective and expiration dates, and EXPIRED after
# the expiration date.

class Contract
  attr_reader   :id # unique id
  attr_reader   :purchase_price
  attr_reader   :covered_product

  attr_accessor :status
  attr_accessor :purchase_date
  attr_accessor :effective_date
  attr_accessor :expiration_date
  attr_accessor :in_store_guarantee_days

  attr_accessor :claims

  def initialize(purchase_price, covered_product, purchase_date, effective_date, expiration_date)
    @id                 = SecureRandom.uuid
    @purchase_price     = purchase_price
    @status             = "PENDING"
    @covered_product    = covered_product
    @purchase_date      = purchase_date
    @effective_date     = effective_date
    @expiration_date    = expiration_date
    @claims             = Array.new
  end

  # Equality for entities is based on unique id
  def ==(other)
    self.id == other.id
  end
end
