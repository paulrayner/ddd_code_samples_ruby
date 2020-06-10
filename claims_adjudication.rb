require_relative './contract'
require_relative './claim'
require 'date'

class ClaimAdjudication
  def adjudicate(contract, new_claim)
    claim_total = 0.0
    contract.claims.each { |claim|
      claim_total += claim.amount
    }
    if (contract.purchase_price - claim_total) * 0.8 > new_claim.amount &&
      new_claim.date  >= contract.effective_date &&
      new_claim.date  <= contract.expiration_date &&
      contract.status == "ACTIVE"
      contract.claims << new_claim
    end
  end
end