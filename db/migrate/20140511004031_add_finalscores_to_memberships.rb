class AddFinalscoresToMemberships < ActiveRecord::Migration
  def change
  	change_table :memberships do |t|
  		t.integer :full_final
  		t.integer :full_third
  		t.integer :thid
  		t.integer :champion
  	end
  end
end
