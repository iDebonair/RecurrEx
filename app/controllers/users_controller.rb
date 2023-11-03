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
      if @user.errors[:password].include?("is too short (minimum is 6 characters)")
        flash[:error] = "Password must be at least 6 characters long."
      end
      render 'new'
    end
  end

  def edit
    # @user is already set by the before_action
  end

  def update
    puts "Received parameters: #{user_params}"
    @user = current_user

    if user_params[:first_name].present?
      @user.first_name = user_params[:first_name]
      puts "First name logged"
    end

    if user_params[:last_name].present?
      @user.last_name = user_params[:last_name]
    end

  if user_params[:password].present?
    if user_params[:password].length >= 6
      @user.password = user_params[:password]
      @user.password_confirmation = user_params[:password_confirmation]
    else
      flash[:error] = "Password must be at least 6 characters long."
    end
  end
    
    if @user.update(user_params)
      puts "Fired"
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
