require "test/unit"
require 'date'

require_relative './terms_and_conditions'

class TermsAndConditionsTest < Test::Unit::TestCase

  def test_terms_and_conditions_equality
    # A value object must be created whole
    terms_and_conditions = TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2012, 5, 8), 90)

    # Demonstrate equality of object by property
    assert_equal TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2012, 5, 8), 90), terms_and_conditions
  end

  def test_terms_and_conditions_inequality
    terms_and_conditions = TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2012, 5, 8), 30)

    # Demonstrates inequality by property comprehensively
    assert_not_equal TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2012, 5, 8), 90), terms_and_conditions
    assert_not_equal TermsAndConditions.new(Date.new(2010, 5, 9), Date.new(2010, 5, 8), Date.new(2012, 5, 8), 30), terms_and_conditions
    assert_not_equal TermsAndConditions.new(Date.new(2010, 5, 9), Date.new(2010, 5, 9), Date.new(2012, 5, 8), 30), terms_and_conditions
    assert_not_equal TermsAndConditions.new(Date.new(2010, 5, 9), Date.new(2010, 5, 9), Date.new(2010, 5, 9), 30), terms_and_conditions
  end

  def test_terms_and_conditions_status_pending
    terms_and_conditions = TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2012, 5, 8), 30)

    assert_true  terms_and_conditions.is_pending(Date.new(2010, 5, 7))
    assert_false terms_and_conditions.is_pending(Date.new(2010, 5, 8))
  end

  def test_terms_and_conditions_status_active
    terms_and_conditions = TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2012, 5, 8), 30)

    assert_false terms_and_conditions.is_active(Date.new(2010, 5, 7))
    assert_true  terms_and_conditions.is_active(Date.new(2010, 5, 8))
    assert_true  terms_and_conditions.is_active(Date.new(2012, 5, 8))
    assert_false terms_and_conditions.is_active(Date.new(2012, 5, 9))
  end

  def test_terms_and_conditions_status_expired
    terms_and_conditions = TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2012, 5, 8), 30)

    assert_false terms_and_conditions.is_expired(Date.new(2012, 5, 8))
    assert_true  terms_and_conditions.is_expired(Date.new(2012, 5, 9))
  end

  def test_terms_and_conditions_status
    terms_and_conditions = TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2012, 5, 8), 30)

    assert_equal "PENDING", terms_and_conditions.status(Date.new(2010, 5, 7))
    assert_equal "ACTIVE", terms_and_conditions.status(Date.new(2011, 5, 8))
    assert_equal "EXPIRED", terms_and_conditions.status(Date.new(2012, 5, 9))
  end

  def test_terms_and_conditions_extend_annually
    terms_and_conditions = TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2012, 5, 8), 30)

    assert_equal TermsAndConditions.new(Date.new(2010, 5, 8), Date.new(2010, 5, 8), Date.new(2013, 5, 8), 30), terms_and_conditions.annually_extended
  end
end
