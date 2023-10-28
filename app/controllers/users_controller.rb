class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id # Log in the user upon successful signup
      redirect_to user_profile_path(@user)
    else
      render 'new'
    end
  end

  def edit
    # @user is already set by the before_action
  end

  def update
    @user = current_user

    if user_params[:first_name].present?
      @user.first_name = user_params[:first_name]
    end

    if user_params[:last_name].present?
      @user.last_name = user_params[:last_name]
    end

    if user_params[:password].present?
      @user.password = user_params[:password]
      @user.password_confirmation = user_params[:password_confirmation]
    end
    
    if @user.update(user_params)
      flash[:success] = "Profile updated successfully."
      redirect_to user_profile_path(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def require_login
    unless current_user
      redirect_to new_user_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
