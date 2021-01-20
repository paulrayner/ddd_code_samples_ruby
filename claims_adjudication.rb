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
    # TODO: Claims amount is not connected to purchase order amounts
    claim_total = 0.0
    contract.claims.each { |claim|
      claim_total += claim.amount
    }
    # TODO: Refactor towards the Limit of Liability as an explicit concept
    # Some kind of 80% factoring in here
    if limit_of_liability_reached?(contract, claim_total, new_claim)
      contract.claims << new_claim
    end
  end

  # TODO: Update contract to tell us if it is active
  def limit_of_liability_reached?(contract, claim_total, new_claim)
    (contract.purchase_price - claim_total) * 0.8 > new_claim.amount &&
      # Is within the contract period?
      new_claim.date  >= contract.effective_date &&
      new_claim.date  <= contract.expiration_date &&
      contract.status == "ACTIVE"
  end

# TODO: Check this with domain expert
#  def limit_of_liability
#    (contract.purchase_price - claim_total) * 0.8
#  end
end
