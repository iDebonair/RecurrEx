class AddFrequencyToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :frequency, :string
  end
end
