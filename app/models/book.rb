class Book < ApplicationRecord
    validates :Genre,presence: true
    validates :Author,presence: true
    validates :Image,presence: true
    validates :Title,presence: true
    validates :Publisher,presence: true
    validates :Year,presence: true ,length: { maximum: 4 }
end
