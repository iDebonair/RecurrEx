class AddMessageToReminders < ActiveRecord::Migration[7.0]
  def change
    add_column :reminders, :message, :text
  end
end
