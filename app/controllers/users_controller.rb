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
    @user = current_user

    if user_params[:current_password].present?
      unless @user.authenticate(user_params[:current_password])
        flash[:alert] = "Current password is incorrect."
        return render 'edit'
      end

      if user_params[:new_password].present? && user_params[:new_password].length >= 6
        @user.password = user_params[:new_password]
        @user.password_confirmation = user_params[:new_password]
        flash[:notice] = "Password updated successfully."
        return render 'edit'
      else
        flash[:alert] = "New password must be at least 6 characters long."
        return render 'edit'
      end
    end

    if user_params[:first_name].present? || user_params[:last_name].present?
      if @user.update(user_params.slice(:first_name, :last_name))
        flash[:notice] = "Profile updated successfully."
      else
        flash[:alert] = "Failed to update profile: " + @user.errors.full_messages.join(', ')
      end
    end

    if user_params[:current_password].blank? && user_params[:first_name].blank? && user_params[:last_name].blank?
      flash[:alert] = "No changes were made."
      return render 'edit'
    end

    redirect_to user_profile_path(@user)
  end

  
  
  
  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :current_password, :new_password, :password, :password_confirmation)
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
