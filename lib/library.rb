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

    PATH_TO_LIBRARIES_STORE = File.expand_path('./library/store', __dir__)

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

    def form_elem_to_frequency_arr_for(entity, top_amount = orders.length)
      el_to_freq_hash = orders.each_with_object(Hash.new(0)) do |order, h|
        h[order.send(entity)] += 1
      end

      el_to_freq_hash.sort_by { |_ent, freq| -freq }[0...top_amount]
    end

    def top_three_books_with_order_amount
      form_elem_to_frequency_arr_for(:book, 3)
    end

    def top_reader
      form_elem_to_frequency_arr_for(:reader, 1).first[0]
    end

    def save_to_file(filename = 'lib.yaml')
      path = "#{PATH_TO_LIBRARIES_STORE}/#{filename}"
      File.open(path, 'w') { |f| f.write(to_yaml) }
    end

    def self.load_from_file(filename = 'lib.yaml')
      path = "#{PATH_TO_LIBRARIES_STORE}/#{filename}"
      YAML.load_file(path)
    end
  end
end

lib = Library::BookLibrary.load_from_file
fake_data_for_lib(lib)

puts "Top reader: #{lib.top_reader}"
boks_with_order_amount = lib.top_three_books_with_order_amount

puts 'Top books:'

boks_with_order_amount.each_with_index do |arr, i|
  puts "#{i + 1}.#{arr[0]}. Ordered #{arr[1]} times "
end

lib.save_to_file
