class Address
  attr_accessor :address

  def street
    address[:street]
  end

  def city
    address[:city]
  end

  def state
    address[:state]
  end
end

class Location
  attr_reader :address

  def initialize(address)
    @address = address
  end

  def street
    address.street
  end

  def city
    address.city
  end

  def state
    address.state
  end
end

address = Address.new
address.address = ( { state: "IL", city: "Chicago", street: "Racine" })
location = Location.new(address)
puts location.city
puts location.street
puts location.state

class DelegateLocation
  require 'forwardable'

  extend Forwardable

  attr_reader :address
  delegate %i(street city state) => :address

  def initialize(address)
    @address = address
  end
end

location = DelegateLocation.new(address)
puts "From delegate: " + location.city
puts "From delegate: " + location.street
puts "From delegate: " + location.state
