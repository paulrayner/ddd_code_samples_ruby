require "test/unit"
require "date"
require_relative './contract'
require_relative './claim'
require_relative './terms_and_conditions'

class ContractTest < Test::Unit::TestCase

  def test_contract_is_setup_correctly
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")
    terms_and_conditions = TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2013, 5, 8), 90)

    contract = Contract.new(100.0, product, terms_and_conditions)

    assert_equal 100.0, contract.purchase_price
    assert_equal "PENDING", contract.status(Date.new(2010, 5, 7))
    assert_equal "ACTIVE", contract.status(Date.new(2012, 5, 8))
    assert_equal "EXPIRED", contract.status(Date.new(2013, 5, 9))

    assert_equal Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0"), contract.covered_product
    assert_equal TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2013, 5, 8), 90), contract.terms_and_conditions
  end

  def test_limit_of_liability_no_claims
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")
    terms_and_conditions = TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2013, 5, 8), 90)

    contract = Contract.new(100.0, product, terms_and_conditions)
    assert_equal 80.0, contract.limit_of_liability
  end

  def test_limit_of_liability_one_claim
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")
    terms_and_conditions = TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2013, 5, 8), 90)

    contract = Contract.new(100.0, product, terms_and_conditions)

    contract.claims << Claim.new(10.0, Date.new(2010, 10, 1))
    assert_equal 70.0, contract.limit_of_liability
  end

  def test_limit_of_liability_multiple_claims
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")
    terms_and_conditions = TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2013, 5, 8), 90)

    contract = Contract.new(100.0, product, terms_and_conditions)

    contract.claims << Claim.new(10.0, Date.new(2010, 10, 1))
    contract.claims << Claim.new(20.0, Date.new(2010, 10, 1))
    assert_equal 50.0, contract.limit_of_liability
  end

  def test_contract_equality
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")
    terms_and_conditions = TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2013, 5, 8), 90)

    contract1 = Contract.new(100.0, product, terms_and_conditions)
    contract1.id = 100

    contract2 = Contract.new(100.0, product, terms_and_conditions)
    contract2.id = 101

    contract3 = Contract.new(100.0, product, terms_and_conditions)
    contract3.id = 100

    # entities compare by unique IDs, not properties
    assert_not_equal contract1, contract2
    assert_equal contract1, contract3
  end

  def test_terminate_contract
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")
    terms_and_conditions = TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2013, 5, 8), 90)

    contract = Contract.new(100.0, product, terms_and_conditions)

    contract.terminate("Debbie")
    assert_equal "FULFILLED", contract.status(Date.today)
    assert_equal 1, contract.events.length
    assert_true contract.events[0].is_a? CustomerReimbursementRequested
    assert_equal Date.today, contract.events[0].occurred_on
    assert_equal "Debbie", contract.events[0].rep_name
    assert_equal "Limit of Liability Exceeded", contract.events[0].reason
  end

  def test_extend_annual_subscription
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")
    terms_and_conditions = TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2013, 5, 8), 90)

    contract = Contract.new(100.0, product, terms_and_conditions)

    contract.extend_annual_subscription

    assert_equal TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2014, 5, 8), 90), contract.terms_and_conditions
    assert_equal 1, contract.events.length
    assert_equal Date.today, contract.events[0].occurred_on
    assert_true contract.events[0].is_a? SubscriptionRenewed
    assert_equal "Manual Renewal", contract.events[0].reason
  end

end
