require "test/unit"
require "date"
require_relative './terms_and_conditions'

class TermsAndConditionsTest < Test::Unit::TestCase
  def test_creation
    effective_date = Date.new(2020, 1, 1)
    expiration_date = Date.new(2020, 4, 1)
    purchase_date = Date.new(2019, 3, 1)
    in_store_guarantee_days = 90

    terms_and_conditions = TermsAndConditions.new(
      effective_date: effective_date,
      expiration_date: expiration_date,
      purchase_date: purchase_date,
      in_store_guarantee_days: in_store_guarantee_days
    )

    assert_equal effective_date, terms_and_conditions.effective_date
    assert_equal expiration_date, terms_and_conditions.expiration_date
    assert_equal purchase_date, terms_and_conditions.purchase_date
    assert_equal in_store_guarantee_days, terms_and_conditions.in_store_guarantee_days
  end

  def test_equality
    effective_date = Date.new(2020, 1, 1)
    expiration_date = Date.new(2020, 4, 1)
    purchase_date = Date.new(2019, 3, 1)
    in_store_guarantee_days = 90

    terms_and_conditions_one = TermsAndConditions.new(
      effective_date: effective_date,
      expiration_date: expiration_date,
      purchase_date: purchase_date,
      in_store_guarantee_days: in_store_guarantee_days
    )

    terms_and_conditions_two = TermsAndConditions.new(
      effective_date: effective_date,
      expiration_date: expiration_date,
      purchase_date: purchase_date,
      in_store_guarantee_days: in_store_guarantee_days
    )

    assert_equal terms_and_conditions_two, terms_and_conditions_one
  end

  def test_inequality
    effective_date = Date.new(2020, 1, 1)
    expiration_date = Date.new(2020, 4, 1)
    purchase_date = Date.new(2019, 3, 1)
    in_store_guarantee_days = 90

    terms_and_conditions_one = TermsAndConditions.new(
      effective_date: effective_date,
      expiration_date: expiration_date,
      purchase_date: purchase_date,
      in_store_guarantee_days: in_store_guarantee_days
    )

    terms_and_conditions_two = TermsAndConditions.new(
      effective_date: effective_date,
      expiration_date: expiration_date,
      purchase_date: purchase_date,
      in_store_guarantee_days: in_store_guarantee_days + 1
    )

    assert_not_equal terms_and_conditions_two, terms_and_conditions_one
  end
end
