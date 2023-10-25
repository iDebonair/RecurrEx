class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :reminders, dependent: :destroy

  validates :name, presence: true
  validates :cost, presence: true
  validates :frequency, presence: true
  validates :start_date, presence: true

  def transaction_date
    calculated_date = case frequency
                      when 'Weekly'
                        start_date + ((Date.today - start_date).to_i / 7) * 7
                      when 'Monthly'
                        start_date + ((Date.today.year * 12 + Date.today.month) - (start_date.year * 12 + start_date.month)).months
                      when 'Yearly'
                        start_date + (Date.today.year - start_date.year).years
                      end

    # If the calculated date is in the future, use the last calculated date
    last_calculated_date = calculated_date

    Date.today > calculated_date ? calculated_date : last_calculated_date
  end

  def calculated_renewal_date
    return start_date if start_date.present? && start_date > Date.today
  
    calculated_date = transaction_date
    today = Date.today
  
    case frequency
    when 'Weekly'
      # Add 1 week to the transaction date until it's in the future
      while calculated_date <= today
        calculated_date += 1.week
      end
    when 'Monthly'
      # Add 1 month to the transaction date until it's in the future
      while calculated_date <= today
        calculated_date += 1.month
      end
    when 'Yearly'
      # Add 1 year to the transaction date until it's in the future
      while calculated_date <= today
        calculated_date += 1.year
      end
    end
  
    calculated_date
  end
  
end
