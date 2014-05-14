class AddLastViewedToMemberships < ActiveRecord::Migration
  def change
  	change_table :memberships do |t|
  		t.datetime :last_viewed
  	end
  end
end
