class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :name, presence: true
  validates :renewal_date, presence: true
  validates :cost, presence: true
  validates :frequency, presence: true

  def amount_spent_this_year
    case frequency
    when 'Weekly'
      cost * 52
    when 'Monthly'
      cost * 12
    when 'Yearly'
      cost
    else
      0
    end
  end
end
