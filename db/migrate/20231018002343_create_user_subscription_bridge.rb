class CreateUserSubscriptionBridge < ActiveRecord::Migration[7.0]
  def change
    create_table :user_subscription_bridge do |t|
      t.bigint :user_id, null: false
      t.bigint :subscription_id, null: false

      t.timestamps
    end

    add_index :user_subscription_bridge, [:user_id, :subscription_id], unique: true
  end
end
