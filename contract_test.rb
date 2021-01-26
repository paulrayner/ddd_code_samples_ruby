require "test/unit"
require "date"
require_relative './contract'

class ContractTest < Test::Unit::TestCase

  def test_contract_is_setup_correctly
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")
    contract = Contract.new(100.0, product)
    assert_equal 100, contract.purchase_price
    assert_equal "PENDING", contract.status
    assert_equal Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0"), contract.covered_product
  end

  # entities compare by unique IDs, not properties
  def test_contract_equality
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")
    contract = Contract.new(100.0, product)

    contract_same_id         = contract.clone
    contract_same_id.status  = "ACTIVE"

    assert_equal     contract, contract_same_id

    contract_different_id = Contract.new(100.0, product)
    assert_not_equal contract, contract_different_id
  end
end
