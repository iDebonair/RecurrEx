class HomeController < ApplicationController
  before_action :require_login, except: [:new, :create]


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
    
    def require_login
      unless current_user || request.original_fullpath == root_path
        redirect_to root_path
      end
    end
  end
end