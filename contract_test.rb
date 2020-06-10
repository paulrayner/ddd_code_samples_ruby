require "test/unit"
require "date"
require_relative './contract'

class ContractTest < Test::Unit::TestCase

  def test_contract_is_setup_correctly
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")
    contract = Contract.new(100.0, product)
    assert_equal 100, contract.purchase_price
    assert_equal "PENDING", contract.status
    assert_equal "Whirlpool", contract.covered_product.make
  end
end
