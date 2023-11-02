class UpdateRemindersTable < ActiveRecord::Migration[7.0]
  def change
        remove_column :reminders, :users_id
        remove_column :reminders, :subscriptions_id
  end
end
