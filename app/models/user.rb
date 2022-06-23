class User < ApplicationRecord
  has_many :categories
  has_many :tasks

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email,
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }, # check email format email format
            uniqueness: true

  validates :password,
            length: { minimum: 6 }
end
