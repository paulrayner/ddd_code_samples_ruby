require "test/unit"
require 'date'

require_relative './claim'
require_relative './repair_po'
require_relative './line_item'

class ClaimTest < Test::Unit::TestCase

  def test_claim_is_setup_correctly
    line_item1  = LineItem.new("PARTS", 45.0, "Replacement part for soap dispenser")
    line_item2  = LineItem.new("LABOR", 50.0, "1 hour repair")
    repair_po   = RepairPO.new
    repair_po.line_items << line_item1
    repair_po.line_items << line_item2
    claim       = Claim.new(150.0, Date.new(2010, 5, 8))
    claim.repair_pos << repair_po

    assert_equal 150.0, claim.amount
    assert_equal Date.new(2010, 5, 8), claim.date

    assert_equal "PARTS", claim.repair_pos[0].line_items[0].type
    assert_equal 45.0, claim.repair_pos[0].line_items[0].amount
    assert_equal "Replacement part for soap dispenser", claim.repair_pos[0].line_items[0].description
    assert_equal "LABOR", claim.repair_pos[0].line_items[1].type
    assert_equal 50.0, claim.repair_pos[0].line_items[1].amount
    assert_equal "1 hour repair", claim.repair_pos[0].line_items[1].description
  end

  # entities compare by unique IDs, not properties
  def test_claim_equality
    claim = Claim.new(150.0, Date.new(2010, 5, 8))

    claim_same_id = claim.clone
    claim_same_id.repair_pos << RepairPO.new

    assert_equal claim, claim_same_id

    claim_different_id = Claim.new(150.0, Date.new(2010, 5, 8))
    assert_not_equal claim, claim_different_id
  end
end
