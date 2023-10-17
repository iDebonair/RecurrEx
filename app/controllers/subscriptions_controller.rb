class SubscriptionsController < ApplicationController
  def index
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.user_id = current_user.id

    if @subscription.save
      flash[:notice] = 'Subscription successfully added'
      redirect_to subscriptions_path
    else
      flash[:notice] = 'Subscription successfully not added'
      redirect_to new_subscription_path
    end
  end

  def edit
  end

  private

  def subscription_params
    params.require(:subscription).permit(:name, :cost, :frequency, :renewal_date)
  end
end
