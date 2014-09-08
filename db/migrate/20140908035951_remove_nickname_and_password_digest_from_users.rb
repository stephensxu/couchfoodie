class RemoveNicknameAndPasswordDigestFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :nickname
    remove_column :users, :password_digest
  end

  def down
    add_column :users, :nickname, :string, :null => false
    add_column :users, :password_digest, :null => false
  end
end
