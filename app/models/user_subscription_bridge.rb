class UserSubscriptionBridge < ApplicationRecord
  belongs_to :subscription
  belongs_to :user
end
