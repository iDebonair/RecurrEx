class HomeController < ApplicationController
  before_action :require_login, only: [:index_logged_in]

  def index
    user_id = params[:user_id]
  end

  def index_logged_in
    @categories = Category.all
    @user_subscriptions = current_user.subscriptions
  end

  private

  def require_login
    return if current_user

    redirect_to '/login'
  end
end
