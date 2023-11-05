class HomeController < ApplicationController
  before_action :require_login, except: %i[new create]

  def index
    user_id = params[:user_id]
  end

  def index_logged_in
    # Fetch all subscriptions for the current user
    @subscriptions = current_user.subscriptions
  
    # Create an array of labels for all months (January to December)
    all_months = Date::MONTHNAMES[1..12]
  
    # Initialize a hash to store monthly spending data with default values of 0
    monthly_spending_data = Hash.new(0)
  
    # Iterate through each subscription
    @subscriptions.each do |subscription|
      # Iterate through each renewal date of the subscription
      subscription.all_renewal_dates.each do |renewal_date|
        # Check if the renewal date is in the past
        if renewal_date <= Date.today
          # Calculate the month and year of the renewal date
          month_year = renewal_date.strftime('%B %Y')
  
          # Add the cost of the subscription to the corresponding month in the hash
          monthly_spending_data[month_year] += subscription.cost
        end
      end
    end
  
    # Create arrays for labels and data, filling in missing months with zero spending
    @monthly_labels = all_months.map { |month| "#{month} #{Date.today.year}" }
    @monthly_spending = all_months.map { |month| monthly_spending_data["#{month} #{Date.today.year}"] }
  end

  private

  def require_login
    return if current_user

    def require_login
      return if current_user || request.original_fullpath == root_path

      redirect_to root_path
    end
  end
end
