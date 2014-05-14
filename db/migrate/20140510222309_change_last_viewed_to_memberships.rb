class ChangeLastViewedToMemberships < ActiveRecord::Migration
  def change
  	change_column :memberships, :last_viewed, :time
  end
end
