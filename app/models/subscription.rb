class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :reminders, dependent: :destroy

  validates :name, presence: true
  validates :renewal_date, presence: true
  validates :cost, presence: true
  validates :frequency, presence: true
  validates :start_date, presence: true

  def transaction_date
    if renewal_date.present? && renewal_date <= Date.today
      renewal_date
    elsif start_date.present? && start_date <= Date.today
      start_date
    end
  end
end
