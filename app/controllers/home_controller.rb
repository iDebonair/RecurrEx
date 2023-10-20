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

     # Iterate through categories
     @categories.each do |category|
       # Filter subscriptions for the current category
       subscriptions_in_category = @subscriptions.where(category: category)
 
       # Initialize the total cost for this category
       total_cost = 0.0
 
       # Iterate through subscriptions in the category
       subscriptions_in_category.each do |subscription|
         # Calculate the cost based on frequency
         if subscription.frequency == 'Weekly'
           total_cost += subscription.cost * 52  # Assuming 52 weeks in a year
         elsif subscription.frequency == 'Monthly'
           total_cost += subscription.cost * 12  # Assuming 12 months in a year
         elsif subscription.frequency == 'Yearly'
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
