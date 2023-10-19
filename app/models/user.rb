class User < ApplicationRecord
   has_many :user_subscription_bridge
   has_many :subscriptions, through: :user_subscription_bridge
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :password, presence: true, confirmation: true

  
  
    has_secure_password
  end
  