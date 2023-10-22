class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :reminders, dependent: :destroy

  validates :name, presence: true
  validates :renewal_date, presence: true
  validates :cost, presence: true
  validates :frequency, presence: true

  def amount_spent_this_year
    return 0.0 unless start_date.present?  # Return 0 if start_date is not set
  
    today = Date.today
    end_of_year = Date.new(today.year, 12, 31)  # End of the current year
  
    return 0.0 if start_date > end_of_year  # Return 0 if start_date is later than the end of the year
  
    # Calculate the total amount based on the frequency
    case frequency
    when 'Weekly'
      (today - start_date).to_i / 7 * cost
    when 'Monthly'
      (today.year * 12 + today.month - (start_date.year * 12 + start_date.month)) * cost
    when 'Yearly'
      cost
    else
      0
    end
  end
end
