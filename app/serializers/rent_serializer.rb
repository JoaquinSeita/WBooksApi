class RentSerializer < ApplicationSerializer
  attributes :id, :to, :from, :returned_at
  has_many :book
  has_many :user
end
