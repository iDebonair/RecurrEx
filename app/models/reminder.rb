class Reminder < ApplicationRecord
  belongs_to :users
  belongs_to :subscriptions
end
