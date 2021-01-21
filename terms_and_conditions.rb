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
    current_status = "UNKNOWN"
    if is_pending(current_date)
      current_status = "PENDING"
    elsif is_active(current_date)
      current_status = "ACTIVE"
    elsif is_expired(current_date)
      current_status = "EXPIRED"
    else
      current_status = "UNKNOWN"
    end
    current_status
  end

  def is_pending(current_date)
    return current_date < @effective_date
  end

  def is_active(current_date)
    return current_date >= @effective_date &&
           current_date <= @expiration_date
  end

  def is_expired(current_date)
    return current_date > @expiration_date
  end

  def annually_extended
    return TermsAndConditions.new(@effective_date, @purchase_date, @expiration_date.next_year(1), @in_store_guarantee_days)
  end
end
