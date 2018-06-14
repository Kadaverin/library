# //
class Book
  attr_reader :title, :author

  def initialize(title, author)
    raise ArgumentError unless (title.is_a? String) && (author.is_a? Author)
    @title = title
    @author = author
  end

  def ==(other)
    return false unless other.is_a? Book
    @title == other.title && @author == other.author
  end

  def to_s
    "\"#{title}\", #{author.name}"
  end
end
