class Category < ApplicationRecord
  validates :name,
            presence: true,
            length: { minimum: 1, maximum: 128 },
            uniqueness: true
end
