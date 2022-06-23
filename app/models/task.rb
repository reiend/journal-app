class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :name,
            presence: true,
            length: { minimum: 1, maximum: 128 },
            uniqueness: true
  validates :description,
            presence: true,
            length: { minimum: 1, maximum: 256 }

  validates :deadline,
            presence: true

  validate :valid_date

  private

  def valid_date
    errors.add(:deadline, 'invalid date') if deadline < Date.today
  end
end
