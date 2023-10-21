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

    if @subscription.save
      UserSubscriptionBridge.create(user: current_user, subscription: @subscription)
      redirect_to subscriptions_path
    else
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
    params.require(:subscription).permit(:name, :cost, :frequency, :renewal_date, :category_id)
  end

  def require_login
    return if current_user

    redirect_to '/login'
  end
end
