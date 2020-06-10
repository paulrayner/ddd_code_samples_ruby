require "test/unit"
require 'date'
require_relative './claims_adjudication'

class ClaimAdjudicationTest < Test::Unit::TestCase

  def test_claims_adjudication_for_valid_claim
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")
    contract = Contract.new(100.0, product)

    contract.effective_date  = Date.new(2010, 5, 8)
    contract.expiration_date = Date.new(2012, 5, 8)
    contract.status          = "ACTIVE"

    claim = Claim.new(79.0, Date.new(2010, 5, 8))

    claim_adjudication = ClaimAdjudication.new
    claim_adjudication.adjudicate(contract, claim)

    assert_equal 1, contract.claims.length
    assert_equal 79.0, contract.claims.first.amount
    assert_equal Date.new(2010, 5, 8), contract.claims.first.date
  end

  def test_claims_adjudication_for_invalid_claim_amount
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")
    contract = Contract.new(100.0, product)

    contract.effective_date  = Date.new(2010, 5, 8)
    contract.expiration_date = Date.new(2012, 5, 8)
    contract.status          = "ACTIVE"

    claim = Claim.new(81.0, Date.new(2010, 5, 8))

    claim_adjudication = ClaimAdjudication.new
    claim_adjudication.adjudicate(contract, claim)

    assert_equal 0, contract.claims.length
  end

  def test_claims_adjudication_for_pending_contract
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")
    contract = Contract.new(100.0, product)

    contract.effective_date  = Date.new(2010, 5, 8)
    contract.expiration_date = Date.new(2012, 5, 8)

    claim = Claim.new(79.0, Date.new(2010, 5, 8))

    claim_adjudication = ClaimAdjudication.new
    claim_adjudication.adjudicate(contract, claim)

    assert_equal 0, contract.claims.length
  end

  def test_claims_adjudication_for_contract_prior_to_effective_date
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")
    contract = Contract.new(100.0, product)

    contract.effective_date  = Date.new(2010, 5, 8)
    contract.expiration_date = Date.new(2012, 5, 8)

    claim = Claim.new(79.0, Date.new(2010, 5, 5))

    claim_adjudication = ClaimAdjudication.new
    claim_adjudication.adjudicate(contract, claim)

    assert_equal 0, contract.claims.length
  end

  def test_claims_adjudication_for_expired_contract
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")
    contract = Contract.new(100.0, product)

    contract.effective_date  = Date.new(2010, 5, 8)
    contract.expiration_date = Date.new(2012, 5, 8)
    contract.status          = "EXPIRED"

    claim = Claim.new(79.0, Date.new(2010, 5, 8))

    claim_adjudication = ClaimAdjudication.new
    claim_adjudication.adjudicate(contract, claim)

    assert_equal 0, contract.claims.length
  end

  def test_claims_adjudication_for_contract_after_to_expiration_date
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")
    contract = Contract.new(100.0, product)

    contract.effective_date  = Date.new(2010, 5, 8)
    contract.expiration_date = Date.new(2012, 5, 8)

    claim = Claim.new(79.0, Date.new(2012, 5, 9))

    claim_adjudication = ClaimAdjudication.new
    claim_adjudication.adjudicate(contract, claim)

    assert_equal 0, contract.claims.length
  end
end
