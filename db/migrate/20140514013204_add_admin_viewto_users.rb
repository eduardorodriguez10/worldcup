class AddAdminViewtoUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.boolean :admin_view
  	end
  end
end
