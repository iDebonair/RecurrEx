class CreateUserSubscriptionsBridges < ActiveRecord::Migration[7.0]
  def change
    create_table :user_subscriptions_bridges do |t|
      t.integer :user_id
      t.integer :subscription_id
      t.references :users, null: false, foreign_key: true
      t.references :subscriptions, null: false, foreign_key: true

      t.timestamps
    end
  end
end
