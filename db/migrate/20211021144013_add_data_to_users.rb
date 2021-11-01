class AddDataToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :unread_notifications_count, :integer, null: false, default: 0
    add_column :users, :rents_count, :integer, null: false, default: 0
    add_column :users, :comments_count, :integer, null: false, default: 0
    add_column :users, :wishes_count, :integer, null: false, default: 0
    add_column :users, :locale, :string, null: false, default: "en"
    add_column :users, :image_url, :string, null: false
  end
end
