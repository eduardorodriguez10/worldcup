class AddPrivatetoGroups < ActiveRecord::Migration
  def change
  	change_table :groups do |t|
  		t.boolean :private
  	end
  end
end
