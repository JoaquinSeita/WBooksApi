class BookSerializer < ApplicationSerializer
  attributes :genre, :author, :image, :title, :publisher, :year, :available
end
