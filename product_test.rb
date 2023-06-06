require "test/unit"
require "date"
require_relative './product'

class ProductTest < Test::Unit::TestCase
  def test_product_equality
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0");

    # Demonstrate equality by property
    assert_equal Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0"), product
end

def test_product_inequality
    product  = Product.new("dishwasher", "OEUOEU23", "Whirlpool", "7DP840CWDB0");
    
    # Demonstrate inequality by property
    assert_not_equal Product.new("stove", "OEUOEU23", "Whirlpool", "7DP840CWDB0"), product
    assert_not_equal Product.new("dishwasher", "BEUOEU23", "Whirlpool", "7DP840CWDB0"), product
    assert_not_equal Product.new("dishwasher", "OEUOEU23", "Maytag", "7DP840CWDB0"), product
    assert_not_equal Product.new("dishwasher", "OEUOEU23", "Whirlpool", "99999"), product
  end
end