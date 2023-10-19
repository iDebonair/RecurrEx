class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :name, presence: true
  validates :renewal_date, presence: true
  validates :cost, presence: true
  validates :frequency, presence: true
end
