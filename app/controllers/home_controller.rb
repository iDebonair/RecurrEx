class HomeController < ApplicationController
    def index
      user_id = params[:user_id]
    end

    def index_logged_in
      @categories = Category.all
      @user_subscriptions = current_user.subscriptions
    end

    def amount_spent_this_year(subscription)
      current_year = Date.today.year
      subscription.reminders
                  .where(email: true, timing: current_year)
                  .sum(:cost)
    end
  end
  