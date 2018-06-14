# //
class Author
  attr_accessor :biography
  attr_reader :name

  def initialize(name, biography)
    @name = name
    @biography = biography
  end

  def ==(other)
    return false unless other.is_a? Author
    @name == name &&
      @biography == other.biography
  end

  def to_s
    "#{name}\n#{@biography}\n"
  end
end
