class Rent < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :user_id, presence: true
  validates :book_id, presence: true
  validates :from, presence: true
  validates :to, presence: true
end
