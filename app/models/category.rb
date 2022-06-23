class Category < ApplicationRecord
  has_many :tasks
  belongs_to :user

  validates :name,
            presence: true,
            length: { minimum: 1, maximum: 128 },
            uniqueness: true
end
