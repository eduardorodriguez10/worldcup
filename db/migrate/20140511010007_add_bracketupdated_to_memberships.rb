class AddBracketupdatedToMemberships < ActiveRecord::Migration
  def change
  	change_table :memberships do |t|
  		t.datetime :bracket_updated_at
  	end
  end
end
