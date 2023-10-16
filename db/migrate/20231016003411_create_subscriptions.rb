class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.float :cost
      t.date :renewal_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
