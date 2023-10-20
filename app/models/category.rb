class Category < ApplicationRecord
  has_many :subscriptions

  def total_cost
    current_year = Date.current.year
    subscriptions_this_year = subscriptions.where('extract(year from renewal_date) = ?', current_year)

    total_cost = 0.0
    subscriptions_this_year.each do |subscription|
      total_cost += case subscription.frequency
                    when 'Weekly'
                      subscription.cost * 52
                    when 'Monthly'
                      subscription.cost * 12
                    when 'Yearly'
                      subscription.cost
                    else
                      0.0
                    end
    end

    total_cost
  end
end
