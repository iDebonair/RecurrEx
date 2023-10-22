class CreatePopularSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :popular_subscriptions do |t|
      t.string :name
      t.string :logo

      t.timestamps
    end
  end
end
