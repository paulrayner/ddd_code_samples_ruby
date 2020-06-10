class LineItem
  attr_reader :type
  attr_reader :amount
  attr_reader :description

  def initialize(type, amount, description)
    @type        = type
    @amount      = amount
    @description = description
  end
end