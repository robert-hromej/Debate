class RenameOauthLoginToToken < ActiveRecord::Migration
  def self.up
    rename_column :users, :oauth_login, :oauth_token
  end

  def self.down
    rename_column :users, :oauth_token, :oauth_login
  end
end
