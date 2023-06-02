require "test/unit"
require 'date'
require_relative './claims_adjudication'

class ClaimsAdjudicationTest < Test::Unit::TestCase
    def fake_contract
      product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")
      contract = Contract.new(100.0, product, Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2012, 5, 8))

      contract.status          = "ACTIVE"

      contract
  end

  def test_claims_adjudication_for_valid_claim
    contract = fake_contract
    claim = Claim.new(79.0, Date.new(2010, 5, 8))

    claims_adjudication = ClaimsAdjudication.new
    claims_adjudication.adjudicate(contract, claim)

    assert_equal 1, contract.claims.length
    assert_equal 79.0, contract.claims.first.amount
    assert_equal Date.new(2010, 5, 8), contract.claims.first.failure_date
  end

  def test_claims_adjudication_for_invalid_claim_amount
    contract = fake_contract
    claim = Claim.new(81.0, Date.new(2010, 5, 8))

    claims_adjudication = ClaimsAdjudication.new
    claims_adjudication.adjudicate(contract, claim)

    assert_equal 0, contract.claims.length
  end

  def test_claims_adjudication_for_pending_contract
    contract = fake_contract
    contract.status = "PENDING"
    claim = Claim.new(79.0, Date.new(2010, 5, 8))

    claims_adjudication = ClaimsAdjudication.new
    claims_adjudication.adjudicate(contract, claim)

    assert_equal 0, contract.claims.length
  end

  def test_claims_adjudication_for_contract_prior_to_effective_date
    contract = fake_contract
    claim = Claim.new(79.0, Date.new(2010, 5, 5))

    claims_adjudication = ClaimsAdjudication.new
    claims_adjudication.adjudicate(contract, claim)

    assert_equal 0, contract.claims.length
  end

  def test_claims_adjudication_for_expired_contract
    contract = fake_contract
    contract.status          = "EXPIRED"

    claim = Claim.new(79.0, Date.new(2010, 5, 8))

    claims_adjudication = ClaimsAdjudication.new
    claims_adjudication.adjudicate(contract, claim)

    assert_equal 0, contract.claims.length
  end

  def test_claims_adjudication_for_contract_after_expiration_date
    contract = fake_contract
    claim = Claim.new(79.0, Date.new(2012, 5, 9))

    claims_adjudication = ClaimsAdjudication.new
    claims_adjudication.adjudicate(contract, claim)

    assert_equal 0, contract.claims.length
  end
end
