class AddOthersCanCreatetoGroups < ActiveRecord::Migration
  def change
  	 	change_table :groups do |t|
  		t.boolean :others_can_invite
  		end
  end
end
