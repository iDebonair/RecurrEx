class HomeController < ApplicationController
    def index
      user_id = params[:user_id]
    end

    def index_logged_in
      @categories = Category.all
      @user_subscriptions = current_user.subscriptions
    end
  end
  