class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false
    #adds admin column with default false ie NOT admin
  end
end
