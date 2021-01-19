class Product
  attr_reader :name, :serial_number, :make, :model
  def initialize(name, serial_number, make, model)
    @name           = name
    @serial_number  = serial_number
    @make           = make
    @model          = model
  end

  def ==(other)
    self.class      == other.class &&
    @name           == other.name &&
    @serial_number  == other.serial_number &&
    @make           == other.make &&
    @model          == other.model
  end
  alias :eql? :==
end
