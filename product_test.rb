require "test/unit"

require_relative './product'

class ProductTest < Test::Unit::TestCase

  def test_product_equality
    # A value object must be created whole
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")

    # Demonstrate equality of object by property
    assert_equal Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0"), product
  end

  def test_product_inequality
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0")

    # Demonstrates inequality by property
    assert_not_equal Product.new("stove", "OEUOEU23", "Whirlpool", "7DP840CWDB0"), product
    assert_not_equal Product.new("dishwasher", "EUOEUOE", "Whirlpool", "7DP840CWDB0"), product
    assert_not_equal Product.new("dishwasher", "OEUOEU23", "Maytag", "7DP840CWDB0"), product
    assert_not_equal Product.new("dishwasher", "OEUOEU23", "Whirlpool", "99999999"), product
  end
end
