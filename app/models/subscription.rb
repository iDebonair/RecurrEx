class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :reminders, dependent: :destroy

  validates :name, presence: true
  validates :renewal_date, presence: true
  validates :cost, presence: true
  validates :frequency, presence: true
  validates :start_date, presence: true
end
