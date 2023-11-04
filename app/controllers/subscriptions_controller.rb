class SubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:destroy]
  before_action :require_login
  def index
    @user = current_user
    @subscriptions = @user.subscriptions
  end

  def new
    @subscription = Subscription.new
    @popular_subscriptions = PopularSubscription.all
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.user_id = current_user.id
    renewal_dates = calculated_renewal_dates(subscription_params.renewal_date)
  
    if @subscription.save
      UserSubscriptionBridge.create(user: current_user, subscription: @subscription)
  
      renewal_dates.each do |date|
        # Create a new subscription for each renewal date
        new_subscription = Subscription.new(subscription_params)
        new_subscription.user_id = current_user.id
        new_subscription.renewal_date = date
        if new_subscription.save
          UserSubscriptionBridge.create(user: current_user, subscription: new_subscription)
        else
          # Handle any errors when saving the new subscription
          flash[:error] = "Error creating a subscription for #{date}: #{new_subscription.errors.full_messages.join(', ')}"
        end
      end
  
      redirect_to subscriptions_path
    else
      # Handle errors when saving the initial subscription
      redirect_to new_subscription_path
    end
  end
  

  def edit
    @subscription = Subscription.find(params[:id])
  end

  def update
    @subscription = Subscription.find(params[:id])

    if @subscription.update(subscription_params)
      redirect_to subscriptions_path
    else
      render 'edit'
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    redirect_to subscriptions_path
  end

  private

  def subscription_params
    params.require(:subscription).permit(:name, :cost, :frequency, :renewal_date, :category_id, :start_date)
  end

  def calculated_renewal_dates(renewal_date)
    renewal date entered by the user has to duplicated for the other months until the current month


  end

  def require_login
    return if current_user

    redirect_to '/login'
  end
end
