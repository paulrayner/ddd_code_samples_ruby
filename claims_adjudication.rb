require_relative './contract'
require_relative './claim'
require 'date'

class ClaimAdjudication
  def adjudicate(contract, new_claim)
    if (new_claim.amount < contract.limit_of_liability &&
        contract.terms_and_conditions.is_active(new_claim.date))
      contract.claims << new_claim
    end
  end
end