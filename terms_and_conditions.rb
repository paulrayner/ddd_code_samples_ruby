require_relative 'utility/value_object'

class TermsAndConditions < ValueObject
  attr_reader   :effective_date
  attr_reader   :purchase_date
  attr_reader   :expiration_date
  attr_reader   :in_store_guarantee_days

  def initialize(effective_date, purchase_date, expiration_date, in_store_guarantee_days)
    @effective_date          = effective_date
    @purchase_date           = purchase_date
    @expiration_date         = expiration_date
    @in_store_guarantee_days = in_store_guarantee_days
  end

  def status(current_date)
    if pending?(current_date)
      "PENDING"
    elsif active?(current_date)
      "ACTIVE"
    elsif expired?(current_date)
      "EXPIRED"
    else
      "UNKNOWN"
    end
  end

  def pending?(current_date)
    current_date < @effective_date
  end

  def active?(current_date)
    current_date >= @effective_date &&
    current_date <= @expiration_date
  end

  def expired?(current_date)
    current_date > @expiration_date
  end

  def annually_extended()
    TermsAndConditions.new(@effective_date, @purchase_date, @expiration_date.next_year(1), @in_store_guarantee_days)
  end
end
