class AddScreenNameToUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.string :screenname
  	end
  end
end
