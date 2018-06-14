# //
class Reader
  attr_reader :name, :email, :city, :street, :house

  def initialize(name, email, city, street, house)
    @name = name
    @email = email
    @city = city
    @street = street
    @house = house
  end

  def address
    "#{city}, #{street}, #{house}"
  end

  def ==(other)
    return false unless other.is_a? Reader
    @name == otder.name &&
      @email == other.email &&
      @addres == other.address
  end

  def min_info
    "#{name}, #{email}"
  end

  def to_s
    "#{min_info}, #{address}"
  end
end
