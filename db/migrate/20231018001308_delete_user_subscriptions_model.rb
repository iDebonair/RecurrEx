class DeleteUserSubscriptionsModel < ActiveRecord::Migration[7.0]
  def change
    drop_table :user_subscriptions_bridges
  end
end
