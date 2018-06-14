require 'bundler/setup'
require 'library/version.rb'
require 'library/author'
require 'library/book'
require 'library/reader'
require 'library/order'
require 'library/helpers/fake_data_for_lib'
require 'yaml'

module Library
  # //
  class BookLibrary
    attr_reader :authors, :books, :readers, :orders

    def initialize(books = [], authors = [], readers = [], orders = [])
      @authors = authors
      @readers = readers
      @orders = orders
      @books = books
    end

    def add_author(name, bio)
      @authors << Author.new(name, bio)
    end

    def add_book(title, author)
      @books << Book.new(title, author)
    end

    def add_reader(name, email, city, street, house)
      @readers << Reader.new(name, email, city, street, house)
    end

    def make_order(book, reader, date)
      @orders << Order.new(book, reader, date)
    end

    def form_elem_to_frequency_arr_for(entity)
      @orders.each_with_object(Hash.new(0)) do |order, h|
        h[order.send(entity)] += 1
      end.sort_by { |_k, v| -v }
    end

    def top_three_books
      form_elem_to_frequency_arr_for(:book)[0..2].map(&:first)
    end

    def 
  end
end

lib = Library::BookLibrary.new
fake_data_for_lib(lib)

puts lib.top_three_books
