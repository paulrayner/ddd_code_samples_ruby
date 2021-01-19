require_relative './contract'
require_relative './claim'
require 'date'

class ClaimAdjudication
  def adjudicate(contract, new_claim)
    if (new_claim.amount < contract.limit_of_liability &&
        contract.status(new_claim.date) == "ACTIVE")
      contract.claims << new_claim
    end
  end
end
