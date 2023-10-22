class AddStartDateToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :start_date, :date
  end
end
