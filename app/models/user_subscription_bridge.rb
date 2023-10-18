class UserSubscriptionBridge < ApplicationRecord
  self.table_name = 'user_subscription_bridge'
  belongs_to :subscription
  belongs_to :user
end
