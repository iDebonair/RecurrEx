class HomeController < ApplicationController
  before_action :require_login, except: [:new, :create]


  def index
    user_id = params[:user_id]
  end

  def index_logged_in
    @categories = Category.includes(:subscriptions).order('subscriptions.renewal_date DESC')
    @subscriptions = Subscription.select('*, LARGEST(renewal_date, date_added) AS transaction_date')
    .where('GREATEST(renewal_date, date_added) <= ?', Date.current)
    .order(transaction_date: :desc)
    @user = current_user
    @subscriptions = @user.subscriptions
    @transaction_dates = fetch_transaction_dates
    @costs = fetch_costs
    @monthly_data = calculate_monthly_spending
    @monthly_data_json = @monthly_data.to_json.html_safe
    @daily_data = calculate_daily_spending
    @daily_data_json = @daily_data.to_json.html_safe
  end

  private

  def calculate_monthly_spending
    monthly_data = Hash.new(0)
  
    monthly_data['January'] = 0
    monthly_data['February'] = 0
    monthly_data['March'] = 0
    monthly_data['April'] = 0
    monthly_data['May'] = 0
    monthly_data['June'] = 0
    monthly_data['July'] = 0
    monthly_data['August'] = 0
    monthly_data['September'] = 0
    monthly_data['October'] = 0
    monthly_data['November'] = 0
    monthly_data['December'] = 0

    @transaction_dates.each_with_index do |date, index|
      month = date.strftime('%B')
      monthly_data[month] += @costs[index]
    end
  
    monthly_data
  end

  
  def calculate_daily_spending
    daily_data = Hash.new(0)
  
    daily_data['Sunday'] = 0
    daily_data['Monday'] = 0
    daily_data['Tuesday'] = 0
    daily_data['Wednesday'] = 0
    daily_data['Thursday'] = 0
    daily_data['Friday'] = 0
    daily_data['Saturday'] = 0


    @transaction_dates.each_with_index do |date, index|
      day_of_week = date.strftime('%A')
      daily_data[day_of_week] += @costs[index]
    end
  
    daily_data
  end

  
  def calculate_total_spending(frequency)
    @subscriptions
      .select { |subscription| subscription.frequency == frequency }
      .sum(&:cost)
  end

  def fetch_transaction_dates
    @subscriptions.map(&:transaction_date)
  end

  def fetch_costs
    @subscriptions.map(&:cost)
  end

  def require_login
    return if current_user
    
    def require_login
      unless current_user || request.original_fullpath == root_path
        redirect_to root_path
      end
    end
  end
end