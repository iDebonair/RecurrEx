class AddLinkToPopularSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :popular_subscriptions, :link, :string
  end
end
