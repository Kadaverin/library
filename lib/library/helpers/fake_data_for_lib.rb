require 'faker'
require 'json'

def time_rand(from = 0.0, to = Time.now)
  Time.at(from + rand * (to.to_f - from.to_f))
end

def fake_data_for_lib(lib)
  path_to_books = File.expand_path('../store/books_for_faker.json', __dir__)
  books_hashes = JSON.parse(File.read(path_to_books))
  generate_lib(books_hashes, lib)
end

def generate_lib(books_hashes, lib)
  books_hashes.size.times do |i|
    title = books_hashes[i]['title']
    author_name = books_hashes[i]['author']
    lib.add_author(author_name, Faker::Lovecraft.paragraph)
    lib.add_reader(*fake_data_for_reader)
    lib.add_book(title, lib.authors[i])
  end
  make_rand_orders(lib)
end

def make_rand_orders(lib)
  1000.times do
    lib.make_order(lib.books.sample,
                   lib.readers.sample,
                   time_rand(Time.local(2015, 1, 1)))
  end
end

def fake_data_for_reader
  [
    Faker::Name.name, Faker::Internet.free_email,
    Faker::Address.city, Faker::Address.street_name,
    Faker::Number.between(1, 300)
  ]
end
