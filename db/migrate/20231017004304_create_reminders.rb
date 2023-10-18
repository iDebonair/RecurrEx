class CreateReminders < ActiveRecord::Migration[7.0]
  def change
    create_table :reminders do |t|
      t.integer :user_id
      t.integer :subscription_id
      t.boolean :email
      t.integer :timing
      t.text :frequency
      t.references :users, null: false, foreign_key: true
      t.references :subscriptions, null: false, foreign_key: true

      t.timestamps
    end
  end
end
