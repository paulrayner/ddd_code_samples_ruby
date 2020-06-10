require_relative './utility/value_object'

class Product < ValueObject

  attr_reader :name, :serial_number, :make, :model

  def initialize(name, serial_number, make, model)
    @name           = name
    @serial_number  = serial_number
    @make           = make
    @model          = model
  end
end