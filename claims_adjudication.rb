require_relative './contract'
require_relative './claim'
require 'date'

# Adjudicate/adjudication - a judgment made on a claim to determine whether
# we are legally obligated to process the claim against the warranty. From
# Wikipedia (https://en.wikipedia.org/wiki/Adjudication):
#
#  "Claims adjudication" is a phrase used in the insurance industry to refer to
#  the process of paying claims submitted or denying them after comparing claims
#  to the benefit or coverage requirements.

class ClaimsAdjudication
  def adjudicate(contract, new_claim)
    if limit_of_liability(contract) > new_claim.amount &&
      current_status(contract, new_claim.date)
      contract.claims << new_claim
    end
  end

  # These two new methods we've added seem to be responsibilities of Contract.
  # Let's move them...
  def limit_of_liability(contract)
    claim_total = 0.0
    contract.claims.each { |claim|
      claim_total += claim.amount
    }
    (contract.purchase_price - claim_total) * 0.8
  end

  def current_status(contract, current_date)
    current_date  >= contract.effective_date &&
    current_date  <= contract.expiration_date &&
    contract.status == "ACTIVE"
  end
end
