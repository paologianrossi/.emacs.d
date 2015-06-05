class AddMoreDataToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :image_url, :string
    add_column :users, :gender, :string
    add_column :users, :link, :string
    add_column :users, :locale, :string
    add_column :users, :significant_other_uid, :string
  end
end
