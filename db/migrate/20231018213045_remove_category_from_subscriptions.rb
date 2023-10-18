class RemoveCategoryFromSubscriptions < ActiveRecord::Migration[7.0]
  def change
    remove_column :subscriptions, :category_id, :bigint
  end
end
