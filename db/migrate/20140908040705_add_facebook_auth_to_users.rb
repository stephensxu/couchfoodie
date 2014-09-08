class AddFacebookAuthToUsers < ActiveRecord::Migration
  def up
    add_column :users, :provider, :string,    :null => false
    add_column :users, :oauth_token, :string, :null => false
    add_column :users, :uid, :string,         :null => false
    add_column :users, :name, :string,        :null => false
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :nickname, :string
    add_column :users, :image, :string
    add_column :users, :location, :string
    add_column :users, :gender, :string
    add_column :users, :verified, :boolean
    add_column :users, :link, :string
    add_column :users, :timezone, :integer
  end

  def down
    remove_column :users, :provider
    remove_column :users, :oauth_token
    remove_column :users, :uid
    remove_column :users, :name
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :nickname
    remove_column :users, :image
    remove_column :users, :location
    remove_column :users, :gender
    remove_column :users, :verified
    remove_column :users, :link
    remove_column :users, :timezone
  end
end
