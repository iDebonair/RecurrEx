class HomeController < ApplicationController
  before_action :require_login, only: [:index_logged_in]

  def index
    user_id = params[:user_id]
  end

  def index_logged_in
    @categories = Category.all
    @user_subscriptions = current_user.subscriptions
    @subscriptions = Subscription.all

    # Initialize an empty hash to store the total cost for each category
    @category_costs = {}

    # Retrieve the start_date and end_date from the user's input (update these based on your date picker implementation)
    start_date = params[:start_date]
    end_date = params[:end_date]

    @categories.each do |category|
      # Filter subscriptions for the current category
      subscriptions_in_category = @subscriptions.where(category:)

      # Initialize the total cost for this category
      total_cost = 0.0

      # Iterate through subscriptions in the category
      subscriptions_in_category.each do |subscription|
        next if subscription.start_date.nil? # Skip subscriptions with nil start_date
        next if subscription.start_date > end_date || subscription.start_date > start_date

        case subscription.frequency
        when 'Weekly'
          # Calculate the number of weeks within the selected date range
          weeks_within_range = ((end_date - [subscription.start_date, start_date].max).to_i / 7).ceil
          total_cost += subscription.cost * weeks_within_range
        when 'Monthly'
          # Calculate the number of full months within the selected date range
          months_within_range = (1..12).count do |month|
            (start_date..end_date).cover?(Date.new(end_date.year, month, 1))
          end
          total_cost += subscription.cost * months_within_range
        when 'Yearly'
          total_cost += subscription.cost
        end
      end

      # Store the total cost for the category
      @category_costs[category.id] = total_cost
    end
  end

  private

  def require_login
    return if current_user

    redirect_to '/login'
  end
end
